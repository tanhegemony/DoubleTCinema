/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingDetailEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingFoodEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.FoodEntity;
import com.ivt.spring_final_doubletcinema.entities.InvoiceEntity;
import com.ivt.spring_final_doubletcinema.entities.TransactionCinemaEntity;
import com.ivt.spring_final_doubletcinema.enums.TransactionType;
import com.ivt.spring_final_doubletcinema.model.BuyFoodAtCinema;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingDetailService;
import com.ivt.spring_final_doubletcinema.service.BookingFoodService;
import com.ivt.spring_final_doubletcinema.service.BookingService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.FoodService;
import com.ivt.spring_final_doubletcinema.service.InvoiceService;
import com.ivt.spring_final_doubletcinema.service.TransactionCinemaService;
import com.ivt.spring_final_doubletcinema.utils.ExportInvoicesFileExcel;
import java.awt.Desktop;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URL;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author ngoct
 */
@Controller
@RequestMapping("/admin/")
public class ManageInvoiceController {

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private FoodService foodService;

    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private TransactionCinemaService transactionCinemaService;

    @Autowired
    private BookingFoodService bookingFoodService;

    @Autowired
    private BookingDetailService bookingDetailService;

    @Autowired
    HttpSession session;

    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM");
    SimpleDateFormat sdf3 = new SimpleDateFormat("MM");

    public AccountEntity getAccountByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String customerEmail = principal.toString();
        if (principal instanceof UserDetails) {
            customerEmail = ((UserDetails) principal).getUsername();
        }
        AccountEntity account = accountService.findByCustomerEmail(customerEmail);
        model.addAttribute("accountLogin", account);
        return account;
    }

    public void displayMoneyInvoice(Model model) {
        // tổng tất cả hoá đơn
        List<InvoiceEntity> invoices = invoiceService.getInvoices();
        double subTotalInvoices = 0.0;
        for (InvoiceEntity i : invoices) {
            subTotalInvoices += i.getAmount();
        }
        model.addAttribute("subTotalInvoices", subTotalInvoices);

        // tổng hoá đơn năm hiện tại
        double subTotalInvoicesCurrentYear = 0.0;
        List<InvoiceEntity> invoicesCurrentYear = invoiceService.findByInvoiceByDate(sdf1.format(new Date()) + "%");
        for (InvoiceEntity i : invoicesCurrentYear) {
            subTotalInvoicesCurrentYear += i.getAmount();
        }
        model.addAttribute("currentYear", sdf1.format(new Date()));
        model.addAttribute("subTotalInvoicesCurrentYear", subTotalInvoicesCurrentYear);

        // tổng hoá đơn tháng hiện tại
        double subTotalInvoicesCurrentMonth = 0.0;
        List<InvoiceEntity> invoicesCurrentMonth = invoiceService.findByInvoiceByDate(sdf2.format(new Date()) + "%");
        for (InvoiceEntity i : invoicesCurrentMonth) {
            subTotalInvoicesCurrentMonth += i.getAmount();
        }
        model.addAttribute("currentMonth", sdf3.format(new Date()));
        model.addAttribute("subTotalInvoicesCurrentMonth", subTotalInvoicesCurrentMonth);
    }

    @RequestMapping("/invoices")
    public String viewInvoices(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "invoices");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<InvoiceEntity> invoices = invoiceService.getInvoicesPagination(currentPage - 1, pageSize, Sort.by("invoiceDate").descending());
        if (invoices != null) {
            int totalPages = invoices.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("invoices", invoices);
        }
        displayMoneyInvoice(model);
        return "/admin/invoice";
    }

    @RequestMapping(value = "/searchInvoices", method = RequestMethod.GET)
    public String searchInvoices(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_invoices");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<InvoiceEntity> invoices = invoiceService.searchInvoiceByAccountBankingNameAndEmail("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("invoice_date").descending());
        if (invoices != null) {
            int totalPages = invoices.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("invoices", invoices);
        }
        displayMoneyInvoice(model);
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/invoice";
    }

    @RequestMapping("viewBookingInvoice/{id}")
    public String viewInvoiceBybooking(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "view_booking_invoice");
        model.addAttribute("booking", bookingService.getBookingById(id));
        return "/admin/view_booking_invoice";
    }

    @RequestMapping("exportExcel")
    public void exportExcel(Model model, HttpServletResponse response) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        try {
            URL location = ManageAccountBankingController.class.getProtectionDomain().getCodeSource().getLocation();
            String fileName = location.getFile().substring(0, location.getPath().lastIndexOf("WEB-INF")) + "/resources/files/ListInvoices.xlsx";
            XSSFWorkbook wb = new XSSFWorkbook();
            XSSFSheet sheet = null;
            ExportInvoicesFileExcel exi = new ExportInvoicesFileExcel();
            for (int i = Integer.parseInt(sdf1.format(new Date())); i >= 2020; i--) {
                sheet = wb.createSheet(String.valueOf(i));
                exi.configColumnWith(sheet);
                exi.writeHead(wb, sheet);
                List<InvoiceEntity> invoices = invoiceService.findByInvoiceByDate(String.valueOf(i) + "%");
                exi.writeValue(wb, sheet, invoices);

                Row rowTotal = sheet.createRow((short) 6);
                Cell cellValueSubtotal = rowTotal.createCell(6);
                double subtotalYear = 0.0;
                for (InvoiceEntity invoice : invoices) {
                    subtotalYear += invoice.getAmount();
                }
                CellStyle csValue = wb.createCellStyle();
                csValue.setAlignment(HorizontalAlignment.RIGHT);
                Locale locale = new Locale("vi", "VN");
                NumberFormat formatter = NumberFormat.getCurrencyInstance(locale);
                cellValueSubtotal.setCellStyle(csValue);
                cellValueSubtotal.setCellValue("Tổng hoá đơn năm " + i + ": " + formatter.format(subtotalYear));
            }
            OutputStream fileOut = new FileOutputStream(fileName);
            wb.write(fileOut);
            File file = new File(fileName);
            //download file
            exi.downloadFile(response, file);
            // open file
            Desktop.getDesktop().open(file);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/checkViewed/{id}")
    public String checkViewed(Model model,
            @PathVariable("id") long id) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        InvoiceEntity invoice = invoiceService.findByInvoiceID(id);
        if (invoice.getId() > 0) {
            invoice.setStatus("VIEWED");
            invoiceService.saveInvoice(invoice);
        }
        return "redirect:/admin/invoices";
    }

    @RequestMapping("buyFoods/{id}")
    public String buyFoods(Model model,
            @PathVariable("id") long id) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "buyFoods");
        InvoiceEntity invoice = invoiceService.findByInvoiceID(id);
        model.addAttribute("stage", "buyFood");
        if (invoice.getId() > 0) {
            session.setAttribute("invoice", invoice);
            session.setAttribute("foods", foodService.getFoods());
            List<BuyFoodAtCinema> buyFoodsAtCinema = (List<BuyFoodAtCinema>) session.getAttribute("buyFoodsAtCinema");
            if (buyFoodsAtCinema == null) {
                session.setAttribute("subtotal", 0.0);
            }
        } else {
            return "redirect:/admin/invoices";
        }
        return "/admin/form/form_buy_food";
    }

    @RequestMapping(value = "resultBuyFood", method = RequestMethod.POST)
    public String resultBuyFood(Model model, HttpServletRequest request) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "buyFoods");
        InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");
        String food = request.getParameter("food");
        String quantityBuyFood = request.getParameter("quantity_buy_food");
        String buttonAdd = request.getParameter("buttonAdd");
        model.addAttribute("food", food);
        model.addAttribute("quantityBuyFood", quantityBuyFood);
        List<BuyFoodAtCinema> buyFoodsAtCinema = (List<BuyFoodAtCinema>) session.getAttribute("buyFoodsAtCinema");
        double subtotal;
        model.addAttribute("stage", "buyFood");
        if (buyFoodsAtCinema == null) {
            buyFoodsAtCinema = new ArrayList<>();
            subtotal = 0.0;
        } else {
            buyFoodsAtCinema = (List<BuyFoodAtCinema>) session.getAttribute("buyFoodsAtCinema");
            subtotal = (double) session.getAttribute("subtotal");
        }
        if (food != null) {
            FoodEntity findFood = foodService.findById(Long.parseLong(food));
            double subtotalFood = findFood.getPriceFood() * Integer.parseInt(quantityBuyFood);
            model.addAttribute("subtotalFood", subtotalFood);
            if (buttonAdd != null && buttonAdd.equals("addFood")) {
                BuyFoodAtCinema buyFood = new BuyFoodAtCinema(findFood, Integer.parseInt(quantityBuyFood), subtotalFood, invoice);
                buyFoodsAtCinema.add(buyFood);
                session.setAttribute("buyFoodsAtCinema", buyFoodsAtCinema);
                subtotal += buyFood.getSubtotalFood();
                session.setAttribute("subtotal", subtotal);
                return "redirect:/admin/buyFoods/" + invoice.getId();
            } else {
                return "/admin/form/form_buy_food";
            }
        } else {
            model.addAttribute("messageFood", "Please Select Food!");
            return "/admin/form/form_buy_food";
        }

    }

    @RequestMapping("deleteFoodInListBuy/{foodId}")
    public String removeFoodInListBuy(Model model,
            @PathVariable("foodId") long foodId) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "buyFoods");
        InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");
        FoodEntity food = foodService.findById(foodId);
        if (food.getId() > 0) {
            List<BuyFoodAtCinema> buyFoodsAtCinema = (List<BuyFoodAtCinema>) session.getAttribute("buyFoodsAtCinema");
            double subtotal = (double) session.getAttribute("subtotal");
            for (BuyFoodAtCinema bfat : buyFoodsAtCinema) {
                if (food.getId() == bfat.getFood().getId()) {
                    buyFoodsAtCinema.remove(bfat);
                    subtotal = subtotal - bfat.getSubtotalFood();
                    break;
                }
            }
            session.setAttribute("subtotal", subtotal);
        }
        return "redirect:/admin/buyFoods/" + invoice.getId();
    }

    @RequestMapping("completeBuyFood")
    public String completeBuyFood(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "buyFoods");
        model.addAttribute("stage", "completeBuyFood");
        model.addAttribute("cinemas", cinemaService.getCinemas());
        return "/admin/form/form_buy_food";
    }

    @RequestMapping(value = "resultCompleteBuyFood", method = RequestMethod.POST)
    public String resultCompleteBuyFood(Model model, HttpServletRequest request) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "buyFoods");
        InvoiceEntity invoice = (InvoiceEntity) session.getAttribute("invoice");
        if (invoice.getId() > 0) {
            String cinemaId = request.getParameter("cinema");
            model.addAttribute("cinemaId", cinemaId);
            double subtotal = (double) session.getAttribute("subtotal");
            if (cinemaId.equals("")) {
                model.addAttribute("stage", "completeBuyFood");
                model.addAttribute("cinemas", cinemaService.getCinemas());
                model.addAttribute("messageCinema", "Please Select Cinema!");
                return "/admin/form/form_buy_food";
            } else {
                CinemaEntity findCinema = cinemaService.findByCinemaId(Long.parseLong(cinemaId));
                if (findCinema.getId() > 0) {
                    TransactionCinemaEntity transactionCinema = new TransactionCinemaEntity();
                    transactionCinema.setDepositBalance(subtotal);
                    transactionCinema.setStaffName(accountLogin.getCustomer().getCustomerName());
                    transactionCinema.setTransactionDate(new Date());
                    transactionCinema.setTransactionType(TransactionType.BUY_FOODS_AT_CINEMA);
                    transactionCinema.setAccount(accountLogin);
                    transactionCinema.setCinema(findCinema);
                    transactionCinema.setCustomer(invoice.getBooking().getCustomer());
                    transactionCinemaService.saveTransactionCinema(transactionCinema);

                    invoice.setAmount(invoice.getAmount() + subtotal);
                    invoice.setInvoiceDate(new Date());
                    invoiceService.saveInvoice(invoice);

                    BookingEntity booking = bookingService.findBookingById(invoice.getBooking().getId());
                    booking.setBookingDate(new Date());
                    booking.setSubtotal(booking.getSubtotal() + subtotal);
                    bookingService.saveBooking(booking);

                    BookingDetailEntity bookingDetail = bookingDetailService.findById(booking.getBookingDetail().getId());
                    bookingDetail.setTotalPriceFood(bookingDetail.getTotalPriceFood() + subtotal);
                    bookingDetailService.saveBookingDetail(bookingDetail);

                    List<BuyFoodAtCinema> buyFoodsAtCinema = (List<BuyFoodAtCinema>) session.getAttribute("buyFoodsAtCinema");
                    List<BookingFoodEntity> bookingFoods = new ArrayList<>();
                    for (BuyFoodAtCinema bfat : buyFoodsAtCinema) {
                        BookingFoodEntity bookingFood = new BookingFoodEntity(bfat.getQuantityFood(), booking, bfat.getFood());
                        bookingFoods.add(bookingFood);
                    }
                    bookingFoodService.saveListBookingFoods(bookingFoods);

                    session.setAttribute("buyFoodsAtCinema", new ArrayList<>());
                    session.setAttribute("subtotal", 0.0);
                    return "redirect:/admin/invoices";
                } else {
                    model.addAttribute("stage", "completeBuyFood");
                    model.addAttribute("cinemas", cinemaService.getCinemas());
                    model.addAttribute("messageCinema", "Please Select Cinema!");
                    return "/admin/form/form_buy_food";
                }
            }
        } else {
            return "redirect:/admin/invoices";
        }

    }
}

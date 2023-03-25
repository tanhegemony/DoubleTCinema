/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.utils;

import com.ivt.spring_final_doubletcinema.entities.InvoiceEntity;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author ngoct
 */
public class ExportInvoicesFileExcel {

    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM");
    SimpleDateFormat sdf3 = new SimpleDateFormat("MM");
    SimpleDateFormat sdf4 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public void downloadFile(HttpServletResponse response, File file){
        try {
            response.setContentType("text/plain");
            response.setHeader("Content-disposition", "attachment; filename=ListInvoices.xlsx"); // Used to name the download file and its format
            
            OutputStream out = response.getOutputStream();
            FileInputStream in = new FileInputStream(file);
            byte[] buffer = new byte[4096];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
            in.close();
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void configColumnWith(XSSFSheet sheet) {
        sheet.setColumnWidth(0, 1000);
        sheet.setColumnWidth(1, 3000);
        sheet.setColumnWidth(2, 7000);
        sheet.setColumnWidth(3, 6000);
        sheet.setColumnWidth(4, 13000);
        sheet.setColumnWidth(5, 3000);
        sheet.setColumnWidth(6, 5000);
    }

    public void writeValue(XSSFWorkbook wb, XSSFSheet sheet, List<InvoiceEntity> invoices) {
        int j = 1;
        CellStyle csValue = wb.createCellStyle();
        csValue.setAlignment(HorizontalAlignment.CENTER);
        
        CellStyle csValue1 = wb.createCellStyle();
        csValue1.setAlignment(HorizontalAlignment.LEFT);
        
        CellStyle csValue2 = wb.createCellStyle();
        csValue2.setAlignment(HorizontalAlignment.RIGHT);
        for (InvoiceEntity invoice : invoices) {
            Row row = sheet.createRow((short) j);
            Cell cellValueSTT = row.createCell(0);
            cellValueSTT.setCellStyle(csValue);
            cellValueSTT.setCellValue(j);

            Cell cellValueInvoiceID = row.createCell(1);
            cellValueInvoiceID.setCellStyle(csValue);
            cellValueInvoiceID.setCellValue(invoice.getId());

            Cell cellValueAccountBankingNumber = row.createCell(2);
            cellValueAccountBankingNumber.setCellStyle(csValue1);
            cellValueAccountBankingNumber.setCellValue(invoice.getAccountBankingName());

            Cell cellValueCustomerName = row.createCell(3);
            cellValueCustomerName.setCellStyle(csValue1);
            cellValueCustomerName.setCellValue(invoice.getAccountBankingEmail());

            Cell cellValueMovieName = row.createCell(4);
            cellValueMovieName.setCellStyle(csValue1);
            cellValueMovieName.setCellValue(invoice.getBooking().getBookingDetail().getMovie().getNameByEnglish());

            Cell cellValueSubtotal = row.createCell(5);
            cellValueSubtotal.setCellStyle(csValue2);
            Locale locale = new Locale("vi", "VN");
            NumberFormat formatter = NumberFormat.getCurrencyInstance(locale);
            cellValueSubtotal.setCellValue(formatter.format(invoice.getAmount()));

            Cell cellValueInvoiceDate = row.createCell(6);
            cellValueInvoiceDate.setCellStyle(csValue);
            cellValueInvoiceDate.setCellValue(sdf4.format(invoice.getInvoiceDate()));

            j++;
        }
    }

    public void writeHead(XSSFWorkbook wb, XSSFSheet sheet) {
        Row rowhead = sheet.createRow((short) 0);
        CellStyle csHead = wb.createCellStyle();
        Font font = wb.createFont();
        font.setBold(true);
        csHead.setAlignment(HorizontalAlignment.CENTER);
        csHead.setFont(font);
        Cell cellSTT = rowhead.createCell(0);
        cellSTT.setCellStyle(csHead);
        cellSTT.setCellValue("STT");

        Cell cellInvoiceID = rowhead.createCell(1);
        cellInvoiceID.setCellStyle(csHead);
        cellInvoiceID.setCellValue("InvoiceID");

        Cell cellAccountBankingNumber = rowhead.createCell(2);
        cellAccountBankingNumber.setCellStyle(csHead);
        cellAccountBankingNumber.setCellValue("AccountBankingName");

        Cell cellCustomerName = rowhead.createCell(3);
        cellCustomerName.setCellStyle(csHead);
        cellCustomerName.setCellValue("AccountBankingEmail");

        Cell cellMovieName = rowhead.createCell(4);
        cellMovieName.setCellStyle(csHead);
        cellMovieName.setCellValue("MovieName");

        Cell cellSubtotal = rowhead.createCell(5);
        cellSubtotal.setCellStyle(csHead);
        cellSubtotal.setCellValue("Subtotal");

        Cell cellInvoiceDate = rowhead.createCell(6);
        cellInvoiceDate.setCellStyle(csHead);
        cellInvoiceDate.setCellValue("InvoiceDate");

    }
}

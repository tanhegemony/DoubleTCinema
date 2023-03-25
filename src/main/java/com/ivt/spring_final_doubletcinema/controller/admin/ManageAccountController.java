/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.RoleAccountEntity;
import com.ivt.spring_final_doubletcinema.entities.RoleEntity;
import com.ivt.spring_final_doubletcinema.enums.Gender;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.RoleAccountService;
import com.ivt.spring_final_doubletcinema.service.RoleService;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author TanHegemony
 */
@Controller
@RequestMapping("/admin")
public class ManageAccountController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private RoleAccountService roleAccountService;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

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

    // show list accounts
    @RequestMapping("/accounts")
    public String viewAccount(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "accounts");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<AccountEntity> accounts = accountService.getAccountsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (accounts != null) {
            // record / pageSize
            int totalPages = accounts.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("accounts", accounts);

        }
        return "/admin/account";
    }

    // search accounts
    @RequestMapping(value = "searchAccounts", method = RequestMethod.GET)
    public String searchAccount(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_accounts");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<AccountEntity> accounts = null;
        if (searchValue.equals("")) {
            accounts = accountService.getAccountsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        } else {
            accounts = accountService.searchAccountsPagination("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("id").descending());
        }
        if (accounts != null) {
            int totalPages = accounts.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("accounts", accounts);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/account";

    }
// view form add accounts

    @RequestMapping("addAccount")
    public String addAccount(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_account");
        model.addAttribute("genders", Gender.values());
        model.addAttribute("roles", roleService.getRoles());
        return "/admin/form/form_account";
    }
// result add and update account
    // delete account

    @RequestMapping("deleteAccount/{id}")
    public String deleteAccount(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        accountService.deleteAccount(id);
        return "redirect:/admin/accounts";
    }

    @RequestMapping("editAccount/{id}")
    public String updateAccount(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        AccountEntity account = accountService.findById(id);
        List<RoleEntity> roles = roleService.getRoles();
        if (account.getId() > 0) {
            model.addAttribute("action", "update_account");
            for (RoleEntity r : roles) {
                for (RoleAccountEntity ra : account.getRolesAccount()) {
                    if (r.getRoleAccount().equals(ra.getRole().getRoleAccount())) {
                        r.setExistRoleAccount(true);
                        break;
                    }
                }
            }
        } else {
            model.addAttribute("action", "add_account");
        }
        model.addAttribute("genders", Gender.values());
        model.addAttribute("roles", roles);
        model.addAttribute("birthDate", sdf.format(account.getCustomer().getBirthDate()));
        model.addAttribute("createdDate", sdf1.format(account.getCreateDate()));
        model.addAttribute("account", account);
        return "/admin/form/form_account";
    }

    @RequestMapping(value = "/resultSaveAccount", method = RequestMethod.POST)
    public String saveOrUpdateAccount(
            @Valid @ModelAttribute("account") AccountEntity account,
            BindingResult result,
            @RequestParam(value = "rolesAcc", required = false) String[] rolesAcc,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        URL location = DashboardController.class.getProtectionDomain()
                .getCodeSource().getLocation();
        File fileOriginal = new File(location.getFile());
        String resultPathFile = fileOriginal.getAbsolutePath();
        AccountEntity findAccount = accountService.findById(account.getId());
        List<RoleEntity> roles = roleService.getRoles();
        if (result.hasErrors()) {
            if (account.getId() > 0) {
                model.addAttribute("action", "update_account");
                for (RoleEntity r : roles) {
                    for (RoleAccountEntity ra : findAccount.getRolesAccount()) {
                        if (r.getRoleAccount().equals(ra.getRole().getRoleAccount())) {
                            r.setExistRoleAccount(true);
                            break;
                        }
                    }
                }
                model.addAttribute("createdDate", sdf1.format(account.getCreateDate()));
                model.addAttribute("birthDate", sdf.format(findAccount.getCustomer().getBirthDate()));
            } else {
                model.addAttribute("action", "add_account");
            }
            model.addAttribute("account", account);
            model.addAttribute("genders", Gender.values());
            model.addAttribute("roles", roles);
            return "/admin/form/form_account";
        } else {
            MultipartFile file = account.getImageAcc();
            String saveDirectory = resultPathFile.substring(0, resultPathFile.lastIndexOf(File.separator) - 54) + "\\src\\main\\webapp\\resources\\images\\user";
            Path path = Paths.get(saveDirectory);
            if (!Files.exists(path)) {
                Files.createDirectory(path);
            }
            String filename = file.getOriginalFilename();
            if (filename.length() > 50) {
                model.addAttribute("messageImageAcc", "Image file name must be less than 50 characters");
                model.addAttribute("action", "update_account");
                if (findAccount.getId() > 0) {
                    for (RoleEntity r : roles) {
                        for (RoleAccountEntity ra : findAccount.getRolesAccount()) {
                            if (r.getRoleAccount().equals(ra.getRole().getRoleAccount())) {
                                r.setExistRoleAccount(true);
                                break;
                            }
                        }
                    }
                    model.addAttribute("createdDate", sdf1.format(account.getCreateDate()));
                }
                model.addAttribute("birthDate", sdf.format(account.getCustomer().getBirthDate()));
                model.addAttribute("account", account);
                model.addAttribute("genders", Gender.values());
                model.addAttribute("roles", roles);
                return "/admin/form/form_account";
            } else {
                if (account.getId() > 0) {
                    if (accountService.findByCustomerEmail(account.getCustomer().getCustomerEmail()).getId() > 0
                            && !account.getCustomer().getCustomerEmail().equals(findAccount.getCustomer().getCustomerEmail())) {
                        model.addAttribute("messageCustomerEmail", "CustomerEmail is existed!");
                        model.addAttribute("action", "update_account");
                        model.addAttribute("createdDate", sdf1.format(account.getCreateDate()));
                        model.addAttribute("birthDate", sdf.format(account.getCustomer().getBirthDate()));
                        model.addAttribute("genders", Gender.values());
                        model.addAttribute("roles", roleService.getRoles());
                        model.addAttribute("rolesAcc", rolesAcc);
                        model.addAttribute("account", account);
                        return "/admin/form/form_account";
                    } else {
                        if (accountService.findByCustomerPhone(account.getCustomer().getCustomerPhone()).getId() > 0
                                && !account.getCustomer().getCustomerPhone().equals(findAccount.getCustomer().getCustomerPhone())) {
                            model.addAttribute("messagePhoneNumber", "CustomerPhone is existed!");
                            model.addAttribute("action", "update_account");
                            model.addAttribute("createdDate", sdf1.format(account.getCreateDate()));
                            model.addAttribute("birthDate", sdf.format(account.getCustomer().getBirthDate()));
                            model.addAttribute("genders", Gender.values());
                            model.addAttribute("roles", roleService.getRoles());
                            model.addAttribute("rolesAcc", rolesAcc);
                            model.addAttribute("account", account);
                            return "/admin/form/form_account";
                        } else {
                            // update account
                            if (filename == "" || filename.equals("no_image_user.png")) {
                                filename = "no_image_user.png";
                            }
                            if (filename.equals("no_image_user.png") && !account.getImageAccount().equals("no_image_user.png")) {
                                filename = account.getImageAccount();
                            }
                            File filePath = new File(path + "\\" + filename);
                            if (filename != null && !filePath.exists()) {
                                file.transferTo(filePath);
                            }
                            account.setImageAccount(filename);
                            account.setIsLock(false);

                            // update roles
                            List<String> rolesAccString = new ArrayList<>();
                            if (rolesAcc != null) {
                                for (String role : rolesAcc) {
                                    rolesAccString.add(role);
                                }
                            }
                            if (rolesAccString.size() >= 0) {
                                roleAccountService.deleteRoleAccount(findAccount.getRolesAccount());
                            }
                            List<RoleEntity> rolesList = new ArrayList<>();
                            rolesList.add(roles.get(0));
                            for (String roleAccString : rolesAccString) {
                                for (RoleEntity rl : roles) {
                                    if (String.valueOf(rl.getId()).equals(roleAccString)) {
                                        rolesList.add(rl);
                                    }
                                }
                            }
                            List<RoleAccountEntity> roleAccountList = new ArrayList<>();
                            for (RoleEntity r : rolesList) {
                                RoleAccountEntity roleA = new RoleAccountEntity(account, r);
                                roleAccountList.add(roleA);
                            }
                            account.setRolesAccount(roleAccountList);
                            accountService.saveOrUpdateAccount(account);
                            return "redirect:/admin/accounts";
                        }
                    }
                } else {
                    boolean checkExistAccount = accountService.checkExistAccount(model, account.getCustomer().getCustomerEmail(), account.getCustomer().getCustomerPhone());
                    if (checkExistAccount == false) {
                        model.addAttribute("action", "add_account");
                        model.addAttribute("account", account);
                        model.addAttribute("genders", Gender.values());
                        model.addAttribute("birthDate", sdf.format(account.getCustomer().getBirthDate()));
                        model.addAttribute("roles", roleService.getRoles());
                        return "/admin/form/form_account";
                    } else if (checkExistAccount == true) {
                        String pattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&-+=]).{6,}$";
                        if (account.getPassword().matches(pattern) == false) {
                            model.addAttribute("action", "add_account");
                            model.addAttribute("account", account);
                            model.addAttribute("birthDate", sdf.format(account.getCustomer().getBirthDate()));
                            model.addAttribute("roles", roleService.getRoles());
                            model.addAttribute("genders", Gender.values());
                            model.addAttribute("messagePassword", "Password is wrong format!! Please check again!!");
                            return "/admin/form/form_account";
                        } else {
                            if (filename == "") {
                                filename = "no_image_user.png";
                            }
                            File filePath = new File(path + "\\" + filename);
                            if (filename != null && !filePath.exists()) {
                                file.transferTo(filePath);
                            }

                            account.setImageAccount(filename);
                            account.setIsLock(false);
                            account.setCreateDate(new Date());

                            List<String> rolesAccString = new ArrayList<>();
                            if (rolesAcc != null) {
                                for (String role : rolesAcc) {
                                    rolesAccString.add(role);
                                }
                            }
                            List<RoleEntity> rolesList = new ArrayList<>();
                            rolesList.add(roles.get(0));
                            for (String roleAccString : rolesAccString) {
                                for (RoleEntity rl : roles) {
                                    if (String.valueOf(rl.getId()).equals(roleAccString)) {
                                        rolesList.add(rl);
                                    }
                                }
                            }
                            List<RoleAccountEntity> roleAccountList = new ArrayList<>();
                            for (RoleEntity r : rolesList) {
                                RoleAccountEntity roleA = new RoleAccountEntity(account, r);
                                roleAccountList.add(roleA);
                            }
                            account.setRolesAccount(roleAccountList);
                            model.addAttribute("rolesAcc", rolesAcc);
                            accountService.saveOrUpdateAccount(account);
                            return "redirect:/admin/accounts";
                        }
                    }
                }
                return "redirect:/admin/accounts";
            }
        }
    }
}

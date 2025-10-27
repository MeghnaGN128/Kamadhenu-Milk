package com.xworkz.dairy.restcontroller;

import com.xworkz.dairy.dto.AdminDTO;
import com.xworkz.dairy.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping("/")
public class AdminRestController {

    @Autowired
    AdminService adminService;


    @PostMapping("/api/admindetails")
    public ResponseEntity<String> saveAdminDetails(@Valid @RequestBody AdminDTO adminDTO,
                                                   BindingResult bindingResult) {
        System.out.println("saveAdminDetails method in rest controller");

        if (bindingResult.hasErrors()) {
            System.out.println("Error in fields");
            bindingResult.getFieldErrors()
                    .forEach(fieldError -> System.out.println(fieldError.getField() + "-> " + fieldError.getDefaultMessage()));
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Errors in fields");
        }
        if (adminService.save(adminDTO)) {
            return ResponseEntity.ok("Details saved");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Invalid details");
        }
    }
}

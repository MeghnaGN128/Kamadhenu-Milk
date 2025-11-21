package com.xworkz.dairy.controller;

import com.xworkz.dairy.dto.AdminDTO;
import com.xworkz.dairy.dto.MilkCollectionDTO;
import com.xworkz.dairy.dto.MilkCollectonAndAgentDTO;
import com.xworkz.dairy.entity.MilkCollectionEntity;
import com.xworkz.dairy.entity.ProductEntity;
import com.xworkz.dairy.service.MilkCollectionService;
import com.xworkz.dairy.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;

@Controller
@Slf4j
public class MilkCollectionController {
    public String saveMilkCollection(MilkCollectionEntity milkCollectionEntity) {
        return "milkCollection";
    }

    @Autowired
    private ProductService productService;

    @Autowired
    private MilkCollectionService milkCollectionService;

    @GetMapping("/milkCollection")
    public String showMilkCollectionForm(Model model) {
        log.info("showMilkCollectionForm() is called");

        List<ProductEntity> products = productService.findAllActiveProducts();
        model.addAttribute("products", products);
        return "milkCollection";

    }

    @GetMapping("/viewCollection")
    public String showViewCollectionForm(@RequestParam(required = false) String date, Model model) {
        log.info("showViewCollectionForm() is called");
        List<MilkCollectionDTO> milkCollectionEntities = milkCollectionService.findAll(date);
        log.info("milkCollectionEntities: {}", milkCollectionEntities);
        model.addAttribute("collectionList", milkCollectionEntities);
        return "viewCollection";
    }

    @PostMapping("/saveProductCollection")
    public String saveProductCollection(MilkCollectionDTO milkCollectionDTO, HttpSession httpSession) {
        log.info("saveProductCollection() is called");

        AdminDTO admin = (AdminDTO) httpSession.getAttribute("adminDTO");

        boolean saved = milkCollectionService.save(milkCollectionDTO, admin);
        log.info("saved: {}", saved);

        return "redirect:/viewCollection";
    }

    //
//    @GetMapping("/viewSingleCollection")
//    public String showViewSingleCollectionForm(@RequestParam int id, Model model) {
//        log.info("showViewSingleCollectionForm() is called");
//        MilkCollectonAndAgentDTO milkCollectonAndAgentDTO=milkCollectionService.findById(id);
//        model.addAttribute("milkCollectonAndAgentDTO", milkCollectonAndAgentDTO);
//        return "viewCollection";
//    }
    @GetMapping("/viewSingleCollection")
    public ResponseEntity<MilkCollectonAndAgentDTO> showViewSingleCollection(@RequestParam int id) {
        log.info("showViewSingleCollection() is called");
        MilkCollectonAndAgentDTO dto = milkCollectionService.findById(id);
        log.info("dto: {}", dto);
        if (dto == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(dto);
    }

}

package com.xworkz.dairy.controller;

import com.xworkz.dairy.entity.MilkCollectionEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@Slf4j
public class MilkCollectionController {
    public String saveMilkCollection(MilkCollectionEntity milkCollectionEntity) {
        return "milkCollection";
    }

    @GetMapping("/milkCollection")
    public String showMilkCollectionForm() {
        log.info("showMilkCollectionForm() is called");
        return "milkCollection";
    }

    @GetMapping("/viewCollection")
    public String showViewCollectionForm() {
        log.info("showViewCollectionForm() is called");
        return "viewCollection";
    }


}

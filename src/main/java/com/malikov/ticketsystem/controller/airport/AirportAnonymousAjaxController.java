package com.malikov.ticketsystem.controller.airport;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author Yurii Malikov
 */
@RestController
@RequestMapping(value = "/ajax/anonymous/airport")
public class AirportAnonymousAjaxController extends AbstractAirportController {

    //@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    //public List<FlightManageableDTO> getAll() {
    //    return super.getAll();
    //}
    //
    @GetMapping(value = "/autocomplete-by-name", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<String> autocompleteAirport(@RequestParam("term") String nameMask) {
        return super.getAirportTosByNameMask(nameMask);
    }


}

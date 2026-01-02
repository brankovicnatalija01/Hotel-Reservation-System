package com.natalija.hotelapp.controller;

import com.natalija.hotelapp.dto.RoomResponseDTO;
import com.natalija.hotelapp.dto.RoomSearchRequestDTO;
import com.natalija.hotelapp.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/rooms")
public class RoomController {

    @Autowired
    private RoomService roomService;

    // Get All Rooms
    @GetMapping
    public ResponseEntity<List<RoomResponseDTO>> getAllRooms() {
        return ResponseEntity.ok(roomService.getAllRooms());
    }

    // Filter by Room Type
    @GetMapping("/filter/type")
    public ResponseEntity<List<RoomResponseDTO>> filterByRoomType(@RequestParam String type) {
        return ResponseEntity.ok(roomService.getRoomsByRoomType(type));
    }

    // Filter by Amenities
    @GetMapping("/filter/amenities")
    public ResponseEntity<List<RoomResponseDTO>> filterByAmenities(@RequestParam List<String> amenities) {
        return ResponseEntity.ok(roomService.getRoomsByAmenities(amenities));
    }

    @PostMapping("/search")
    public ResponseEntity<List<RoomResponseDTO>> searchRooms(@RequestBody RoomSearchRequestDTO request) {
        return ResponseEntity.ok(roomService.search(request));
    }

}

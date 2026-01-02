package com.natalija.hotelapp.service;

import com.natalija.hotelapp.dto.RoomResponseDTO;
import com.natalija.hotelapp.dto.RoomSearchRequestDTO;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public interface RoomService {

    List<RoomResponseDTO> getAllRooms();

    List<RoomResponseDTO> getRoomsByRoomType(String roomTypeName);

    List<RoomResponseDTO> getRoomsByAmenities(List<String> amenities);

    List<RoomResponseDTO> search(RoomSearchRequestDTO request);
}

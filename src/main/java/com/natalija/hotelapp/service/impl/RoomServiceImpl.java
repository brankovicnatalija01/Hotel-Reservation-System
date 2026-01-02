package com.natalija.hotelapp.service.impl;

import com.natalija.hotelapp.dto.RoomResponseDTO;
import com.natalija.hotelapp.dto.RoomSearchRequestDTO;
import com.natalija.hotelapp.entity.Room;
import com.natalija.hotelapp.mapper.impl.RoomMapper;
import com.natalija.hotelapp.repository.RoomRepository;
import com.natalija.hotelapp.service.RoomService;
import com.natalija.hotelapp.specification.RoomSpecification;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Service
@Transactional
public class RoomServiceImpl implements RoomService {

    private final RoomRepository roomRepository;
    private final RoomMapper roomMapper;

    public RoomServiceImpl(RoomRepository roomRepository, RoomMapper roomMapper) {
        this.roomRepository = roomRepository;
        this.roomMapper = roomMapper;
    }

    @Override
    public List<RoomResponseDTO> getAllRooms() {
        return roomRepository.findAll()
                .stream()
                .map(roomMapper::toDto)
                .toList();
    }

    @Override
    public List<RoomResponseDTO> getRoomsByRoomType(String roomTypeName) {
        String normalized = roomTypeName.trim();

        return roomRepository
                .findByRoomType_NameIgnoreCase(normalized)
                .stream()
                .map(roomMapper::toDto)
                .toList();
    }

    @Override
    public List<RoomResponseDTO> getRoomsByAmenities(List<String> amenities) {
        // normalize input (case-insensitive)
        List<String> normalizedAmenities = amenities.stream()
                .map(String::toLowerCase)
                .toList();

        List<Room> rooms = roomRepository.findRoomsWithAllAmenitiesIgnoreCase(
                normalizedAmenities,
                normalizedAmenities.size()
        );

        return rooms.stream()
                .map(roomMapper::toDto)
                .toList();
    }

    @Override
    public List<RoomResponseDTO> search(RoomSearchRequestDTO request) {

        Specification<Room> specification = RoomSpecification.filter(request);

        return roomRepository.findAll(specification)
                .stream()
                .map(roomMapper::toDto)
                .toList();
    }

}

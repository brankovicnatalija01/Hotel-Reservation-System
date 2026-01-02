package com.natalija.hotelapp.mapper.impl;

import com.natalija.hotelapp.dto.RoomResponseDTO;
import com.natalija.hotelapp.entity.Amenity;
import com.natalija.hotelapp.entity.Room;
import com.natalija.hotelapp.mapper.Mapper;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
public class RoomMapper implements Mapper<RoomResponseDTO, Room> {

    @Override
    public Room toEntity(RoomResponseDTO roomResponseDTO) {
        throw new UnsupportedOperationException(
                "RoomResponseDTO is for read-only operations"
        );
    }

    @Override
    public RoomResponseDTO toDto(Room room) {
        RoomResponseDTO dto = new RoomResponseDTO();
        dto.setId(room.getId());
        dto.setRoomNumber(room.getRoomNumber());
        dto.setPricePerNight(room.getPricePerNight());
        dto.setDescription(room.getDescription());

        if (room.getProperty() != null) {
            dto.setPropertyId(room.getProperty().getId());
            dto.setPropertyName(room.getProperty().getName());
        }

        if (room.getRoomType() != null) {
            dto.setRoomTypeId(room.getRoomType().getId());
            dto.setRoomTypeName(room.getRoomType().getName());
        }

        if (room.getAmenities() != null) {
            dto.setAmenities(
                    room.getAmenities()
                            .stream()
                            .map(Amenity::getName)
                            .collect(Collectors.toList())
            );
        }

        return dto;
    }
    }



package com.natalija.hotelapp.dto.reservation;

import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.io.Serializable;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class ReservationCreateRequestDTO implements Serializable {
    Long roomId;
    Long userId;
    LocalDate checkInDate;
    LocalDate checkOutDate;
}
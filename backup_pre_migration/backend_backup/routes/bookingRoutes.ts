import express from "express";
import { db } from "../src/prisma/db";

const router = express.Router();
router.get("/occupied", async (req, res) => {
  try {
    const { movie, cinema, date, time } = req.query;

    const movieRecord = await db.orm.public.Movie
      .where({
        title: String(movie),
      })
      .first();

    const cinemaRecord = await db.orm.public.Cinema
      .where({
        name: String(cinema),
      })
      .first();

    if (!movieRecord || !cinemaRecord) {
      return res.status(404).json({
        message: "Movie or cinema not found",
      });
    }

    const allShows = await db.orm.public.Show.all();

    const showRecord = allShows.find(
      (show) =>
        show.movieId === movieRecord.id &&
        show.cinemaId === cinemaRecord.id &&
        show.date === String(date) &&
        show.time === String(time)
    );

    if (!showRecord) {
      return res.status(404).json({
        message: "Show not found",
      });
    }

    const bookings = await db.orm.public.Booking.all();

    const showBookings = bookings.filter(
      (booking) => booking.showId === showRecord.id
    );

    const seatIds = showBookings.map(
      (booking) => booking.seatId
    );

    const allSeats = await db.orm.public.Seat.all();

    const occupiedSeats = allSeats
      .filter((seat) => seatIds.includes(seat.id))
      .map((seat) => seat.seatNumber);

    res.json({
      occupiedSeats,
    });
  } catch (error) {
    console.error("Occupied seats error:", error);

    res.status(500).json({
      message: "Failed to fetch occupied seats",
    });
  }
});

router.post("/", async (req, res) => {
  try {
  const {
  bookingId,
  userId,
  movie,
  cinema,
  date,
  time,
  seats,
  totalAmount,
} = req.body;

    // Find movie
    const movieRecord = await db.orm.public.Movie
      .where({
        title: movie,
      })
      .first();

    if (!movieRecord) {
      return res.status(404).json({
        message: "Movie not found",
      });
    }

    // Find cinema
    const cinemaRecord = await db.orm.public.Cinema
      .where({
        name: cinema,
      })
      .first();

    if (!cinemaRecord) {
      return res.status(404).json({
        message: "Cinema not found",
      });
    }

    // Find show
   const allShows = await db.orm.public.Show.all();
   console.log("BOOKING SHOW CHECK:", {
  movieId: movieRecord.id,
  cinemaId: cinemaRecord.id,
  date,
  time,
  allShows,
});

const showRecord = allShows.find(
  (show) =>
    show.movieId === movieRecord.id &&
    show.cinemaId === cinemaRecord.id &&
    show.date === date &&
    show.time === time
);

    if (!showRecord) {
      return res.status(404).json({
        message: "Show not found",
      });
    }

    const selectedSeats = Array.isArray(seats)
      ? seats
      : String(seats).split(",");

    const createdBookings = [];

    
      const seatsToBook = [];

for (const seatNumber of selectedSeats) {
  const cleanSeatNumber = seatNumber.trim();

  const seat = await db.orm.public.Seat
    .where({
      cinemaId: cinemaRecord.id,
      seatNumber: cleanSeatNumber,
    })
    .first();

  if (!seat) {
    return res.status(404).json({
      message: `Seat ${cleanSeatNumber} not found`,
    });
  }

  const existingBooking = await db.orm.public.Booking
    .where({
      showId: showRecord.id,
      seatId: seat.id,
    })
    .first();

  if (existingBooking) {
    return res.status(409).json({
      message: `Seat ${cleanSeatNumber} is already booked.`,
    });
  }

  seatsToBook.push({
    seat,
    seatNumber: cleanSeatNumber,
  });
}

for (const item of seatsToBook) {
  const booking = await db.orm.public.Booking.create({
  bookingId: `${bookingId}-${item.seatNumber}`,
  userId: Number(userId),
  movieId: movieRecord.id,
  cinemaId: cinemaRecord.id,
  showId: showRecord.id,
  seatId: item.seat.id,
  totalAmount: Number(totalAmount),
  status: "CONFIRMED",
});

  createdBookings.push(booking);
}

    res.status(201).json({
      message: "Booking saved successfully",
      bookings: createdBookings,
    });
  } catch (error) {
    console.error("Booking error:", error);

    res.status(500).json({
      message: "Failed to create booking",
    });
  }
});
router.post("/cancel", async (req, res) => {
  try {
    const { bookingId } = req.body;

    if (!bookingId) {
      return res.status(400).json({
        message: "Booking ID is required.",
      });
    }

    const bookings = await db.orm.public.Booking.all();

    const matchingBookings = bookings.filter(
      (booking) =>
        booking.bookingId === bookingId ||
        booking.bookingId.startsWith(`${bookingId}-`)
    );

    if (matchingBookings.length === 0) {
      return res.status(404).json({
        message: "Booking not found.",
      });
    }

    const alreadyCancelled = matchingBookings.some(
      (booking) => booking.status === "CANCELLED"
    );

    if (alreadyCancelled) {
      return res.status(400).json({
        message: "This booking is already cancelled.",
      });
    }

    for (const booking of matchingBookings) {
      await db.orm.public.Booking
        .where({ id: booking.id })
        .update({
          status: "CANCELLED",
        });
    }

    res.json({
      message: "Booking cancelled successfully.",
      bookingId,
    });
  } catch (error) {
    console.error("Cancellation error:", error);

    res.status(500).json({
      message: "Failed to cancel booking.",
    });
  }
});

router.get("/verify/:bookingId", async (req, res) => {
  try {
    const bookingId = String(req.params.bookingId);

    console.log("QR VERIFICATION BOOKING ID:", bookingId);

    const allBookings = await db.orm.public.Booking.all();
    console.log(
  "SAVED BOOKING IDS:",
  allBookings.map((booking) => booking.bookingId)
);

    const matchingBookings = allBookings.filter(
      (booking) =>
        booking.bookingId === bookingId ||
        booking.bookingId.startsWith(`${bookingId}-`)
    );

    if (matchingBookings.length === 0) {
      return res.status(404).json({
        verified: false,
        message: "Booking not found.",
      });
    }

    const cancelled = matchingBookings.some(
      (booking) => booking.status === "CANCELLED"
    );

    if (cancelled) {
      return res.status(409).json({
        verified: false,
        message: "This booking has been cancelled.",
      });
    }

    res.json({
      verified: true,
      message: "Booking verified successfully.",
      bookingId,
      seats: matchingBookings.length,
    });
  } catch (error) {
    console.error("Ticket verification error:", error);

    res.status(500).json({
      verified: false,
      message: "Unable to verify ticket.",
    });
  }
});


router.get("/my/:userId", async (req, res) => {
  try {
    const userId = Number(req.params.userId);

    if (!Number.isInteger(userId) || userId <= 0) {
      return res.status(400).json({
        message: "Invalid user ID",
      });
    }

    const bookings = await db.orm.public.Booking.all();
    const seats = await db.orm.public.Seat.all();
    const movies = await db.orm.public.Movie.all();
    const cinemas = await db.orm.public.Cinema.all();
    const shows = await db.orm.public.Show.all();

    const myBookings = bookings
      .filter((booking: any) => Number(booking.userId) === userId)
      .map((booking: any) => {
        const seat = seats.find(
          (item: any) => Number(item.id) === Number(booking.seatId)
        );

        const movie = movies.find(
          (item: any) => Number(item.id) === Number(booking.movieId)
        );

        const cinema = cinemas.find(
          (item: any) => Number(item.id) === Number(booking.cinemaId)
        );

        const show = shows.find(
          (item: any) => Number(item.id) === Number(booking.showId)
        );

        return {
          ...booking,
          seatNumber: seat?.seatNumber ?? "Unknown",
          movieName: movie?.title ?? null,
          cinemaName: cinema?.name ?? null,
          showDate: show?.date ?? null,
          showTime: show?.time ?? null,
        };
      });

    return res.json(myBookings);
  } catch (error) {
    console.error("My bookings error:", error);

    return res.status(500).json({
      message: "Failed to fetch bookings",
    });
  }
});
export default router;
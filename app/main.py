from fastapi import FastAPI
from pydantic import BaseModel
from typing import List
from datetime import datetime
import uuid

app = FastAPI(title="AutoServe Cloud API", version="1.0.0")


class BookingCreate(BaseModel):
    customer_name: str
    vehicle_reg: str
    service_type: str
    booking_time: datetime


class Booking(BookingCreate):
    id: str


# in-memory store (in real life: Postgres / Cosmos)
BOOKINGS: List[Booking] = []


@app.get("/healthz")
def healthz():
    return {"status": "ok"}


@app.get("/bookings", response_model=List[Booking])
def list_bookings():
    return BOOKINGS


@app.post("/bookings", response_model=Booking, status_code=201)
def create_booking(payload: BookingCreate):
    booking = Booking(id=str(uuid.uuid4()), **payload.dict())
    BOOKINGS.append(booking)
    return booking


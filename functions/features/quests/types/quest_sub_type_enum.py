from enum import Enum


class QuestSubTypeEnum(str, Enum):
    QR_CODE = "qrCode",
    PROMPTED = "prompted",

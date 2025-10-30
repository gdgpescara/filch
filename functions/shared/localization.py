from typing import Dict, Any

# T-shirt notification localization
T_SHIRT_NOTIFICATION_STRINGS = {
    "en": {
        "title": "Alien, it's time to go undercover!",
        "body": "Head to the Intergalactic Supply Division and collect your official t-shirt. Stay sharp. The galaxy’s watching."
    },
    "it": {
        "title": "Alieno, è ora di andare sotto copertura!",
        "body": "Recati alla Divisione Forniture Intergalattica per ritirare la tua t-shirt ufficiale. Rimani vigile. La galassia ti osserva."
    }
}

def get_localized_string(language: str = "en") -> Dict[str, str]:
    """
    Get localized strings for the specified language.
    
    Args:
        language: The language code to use (defaults to 'en')
        
    Returns:
        A dictionary containing the localized strings
    """
    # Currently we only have T_SHIRT_NOTIFICATION strings
    strings = T_SHIRT_NOTIFICATION_STRINGS
    
    # Use the requested language if available, otherwise fallback to English
    if language in strings:
        return strings[language]
    else:
        return strings["en"]

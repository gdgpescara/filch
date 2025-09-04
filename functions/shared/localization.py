from typing import Dict, Any

# T-shirt notification localization
T_SHIRT_NOTIFICATION_STRINGS = {
    "en": {
        "title": "Hey, it's time to pick up your t-shirt!",
        "body": "Go to the gadget desk and ask the staff for your t-shirt. Enjoy it!"
    },
    "it": {
        "title": "Ehi, è il momento di ritirare la tua maglietta!",
        "body": "Vai al desk dei gadget e chiedi allo staff la tua maglietta. Goditela!"
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

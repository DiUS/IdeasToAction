# Swiped from http://robots.thoughtbot.com/i-accidentally-the-whole-smtp-exception.

SMTP_SERVER_ERRORS = [
  IOError,
  Net::SMTPAuthenticationError,
  Net::SMTPServerBusy,
  Net::SMTPUnknownError,
  TimeoutError,
]

SMTP_CLIENT_ERRORS = [Net::SMTPFatalError, Net::SMTPSyntaxError]

SMTP_ERRORS = SMTP_SERVER_ERRORS.concat(SMTP_CLIENT_ERRORS)

SMTP_CLIENT_ERROR_FLASH = 'The email address supplied is invalid. Please check for spelling mistakes.'
SMTP_SERVER_ERROR_FLASH = 'We encountered an internal issue while attempting to deliver this email. Please try again in a few minutes.'

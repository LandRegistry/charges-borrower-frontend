import os

DEBUG = True
DEED_API_BASE_HOST = os.getenv('DEED_API_ADDRESS',
                               'http://deedapi.dev.service.gov.uk')
SCRIBE_API_BASE_HOST = os.getenv('SCRIBE_API_ADDRESS',
                                 'http://scribeapi.dev.service.gov.uk')

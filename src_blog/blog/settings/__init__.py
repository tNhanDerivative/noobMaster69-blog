from .base import *
from dotenv import load_dotenv
load_dotenv()
# you need to set "ENV_SETTING = 'prod'" as an environment variable
# in your OS (on which your website is hosted)
if os.environ['ENV_SETTING'] == 'prod':
   from .prod import *
else:
   from .dev import *
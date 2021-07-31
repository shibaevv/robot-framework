from robot.api.deco import keyword, library

import base64
import jwt
import random
import string
import time

@library(scope='GLOBAL', auto_keywords=True)
class JwtUtils:

    #ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    @keyword('Base64 Encode')
    def base64encode(self, input):
        return base64.b64encode(bytes(input, 'UTF-8'))

    @keyword('Generate Random State')
    def randomState(self):
        return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(11))

    @keyword('Generate Random Nonce')
    def randomNonce(self):
        return ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(12))

    @keyword('Generate Date Expired')
    def dateExpired(self, duration):
        return round(time.time()) + int(duration)

    @keyword('Sign JWT')
    def signJwt(self, claim, privateKey, algorithm, headers):
        return jwt.encode(claim, privateKey, algorithm, headers)

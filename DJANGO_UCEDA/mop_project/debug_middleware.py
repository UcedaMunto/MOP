"""
Middleware para debuggear peticiones
"""
import json
import logging

logger = logging.getLogger(__name__)

class DebugRequestMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Log de peticiones POST
        if request.method == 'POST' and 'niveles-gravedad' in request.path:
            logger.info(f"=== DEBUG REQUEST ===")
            logger.info(f"Path: {request.path}")
            logger.info(f"Method: {request.method}")
            logger.info(f"Content-Type: {request.content_type}")
            logger.info(f"Headers: {dict(request.headers)}")
            
            # Intentar leer el body
            try:
                body = request.body.decode('utf-8')
                logger.info(f"Raw Body: {repr(body)}")
                
                if body:
                    try:
                        parsed_body = json.loads(body)
                        logger.info(f"Parsed JSON: {parsed_body}")
                    except json.JSONDecodeError as e:
                        logger.info(f"JSON Parse Error: {e}")
            except Exception as e:
                logger.info(f"Error reading body: {e}")
            
            logger.info(f"POST data: {request.POST}")
            logger.info(f"=== END DEBUG ===")

        response = self.get_response(request)
        return response
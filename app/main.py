import logging
from typing import Optional
from fastapi import FastAPI, Request, Path, Query

app = FastAPI()
logger = logging.getLogger('uvicorn.info')


@app.middleware("http")
async def log_middle(request: Request, call_next):
    logger.info(f"Client: {request.client.host}:{request.client.port}")
    logger.info("Request:")
    logger.info(f"{request.method} {request.url}")
    logger.info(f"Request path: {request.scope['path']}")
    logger.info("Query Params:")
    for name, value in request.query_params.items():
        logger.info(f"\t{name}: {value}")
    logger.info("Headers:")
    for name, value in request.headers.items():
        logger.info(f"\t{name}: {value}")

    response = await call_next(request)
    return response


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int = Path(..., title="Item ID"),
              q: Optional[str] = Query(None)):
    return {"item_id": item_id, "q": q}


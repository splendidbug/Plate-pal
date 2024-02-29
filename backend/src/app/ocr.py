from typing import List, Dict
from mindee import Client, documents


async def receipt_ocr(
    mindee_client: Client, base64string: str, filename: str
) -> List[str]:
    doc = mindee_client.doc_from_b64string(input_string=base64string, filename=filename)

    # Parse the document as an Invoice by passing the appropriate type
    api_response = doc.parse(documents.TypeInvoiceV4)

    item_list = [
        line_item.description for line_item in api_response.document.line_items
    ]

    return item_list

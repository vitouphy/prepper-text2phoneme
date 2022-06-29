from src.text2phoneme import Text2Phoneme
import json 

def get_error_response():
    return {
        'statusCode': 400,
        'body': 'Invalid request',
        "headers": {
            "Access-Control-Allow-Origin": '*'
        },
        "isBase64Encoded": False
    }

def validate(event):
    if 'queryStringParameters' not in event:
        return False
    if 'text' not in event['queryStringParameters']:
        return False
    return True 
    

def handler(event, context):
    if validate(event) is False:
        return get_error_response()
        
    params = event['queryStringParameters']
    result = Text2Phoneme().convert(params['text'])
    
    responseBody = {
        'phoneme': result['phoneme'],
        'text': params['text']
    }
    if 'breakdown' in params and params['breakdown'].lower() == 'true':
        responseBody['breakdown'] = result['breakdown']

    return {
        "statusCode": 200,
        "headers": {
            "Access-Control-Allow-Origin": '*'
        },
        "body": json.dumps(responseBody),
        "isBase64Encoded": False
    };
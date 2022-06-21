from src.text2phoneme import Text2Phoneme

def get_error_response():
    return {
        'statusCode': 400,
        'body': 'Invalid request'
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
    response = {
        'phoneme': result['phoneme'],
        'text': params['text']
    }
    if 'breakdown' in params and params['breakdown'].lower() == 'true':
        response['breakdown'] = result['breakdown']
    return response
import 'dart:convert';
import 'package:http/http.dart' as http;



const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apikey = '00BF5ED3-652C-41EC-9ED2-C9E7C2E69020';
// const bitcoinAverageURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';
class CoinData {
   Future  getCoinData(String selectedCurrency) async{
     Map<String,String> cryptoPrices = {};
     for(String crypto in cryptoList){
       String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apikey';
       http.Response response = await http.get(requestURL);
       if(response.statusCode==200){
         var decodedData = jsonDecode(response.body);
         double lastPrice = decodedData['rate'];
         cryptoPrices[crypto]=lastPrice.toStringAsFixed(0);
       }
       else {
         print(response.statusCode);
         throw 'Problem with the get request';
       }
     }
     return cryptoPrices;
  }
}

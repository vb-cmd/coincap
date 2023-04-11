# coincap
CoinCap is a useful tool for real-time pricing and market activity for over 1,000 cryptocurrencies. By collecting exchange data from thousands of markets, we are able to offer transparent and accurate data on asset price and availability.

Detailed information [here](https://docs.coincap.io/).

## Assets Price
```Ruby
data = Coincap::AssetsPrice.cryptocurrencies
```
```JSON
    {
        "data": [
            {
             "id": "bitcoin",
             "rank": "1",
             "symbol": "BTC",
             "name": "Bitcoin",
             "supply": "17193925.0000000000000000",
             "maxSupply": "21000000.0000000000000000",
             "marketCapUsd": "119150835874.4699281625807300",
             "volumeUsd24Hr": "2927959461.1750323310959460",
             "priceUsd": "6929.8217756835584756",
             "changePercent24Hr": "-0.8101417214350335",
             "vwap24Hr": "7175.0663247679233209"
            },
         ...
        ],
      "timestamp": 1533581088278
    }
```

```Ruby
data = Coincap::AssetsPrice.cryptocurrency('bitcoin')
```
```JSON
      {
        "data": {
          "id": "bitcoin",
          "rank": "1",
          "symbol": "BTC",
          "name": "Bitcoin",
          "supply": "17193925.0000000000000000",
          "maxSupply": "21000000.0000000000000000",
          "marketCapUsd": "119179791817.6740161068269075",
          "volumeUsd24Hr": "2928356777.6066665425687196",
          "priceUsd": "6931.5058555666618359",
          "changePercent24Hr": "-0.8101417214350335",
          "vwap24Hr": "7175.0663247679233209"
        },
        "timestamp": 1533581098863
      }
```

```Ruby
data = Coincap::AssetsPrice.cryptocurrency_history('bitcoin', :one_minute)
```
```JSON
      {
        "data": [
         {
            "priceUsd": "6379.3997635993342453",
            "time": 1530403200000
          },
        ...
        ],
        "timestamp": 1533581103627
      }
```

```Ruby
data = Coincap::AssetsPrice.cryptocurrency_with_markets('bitcoin')
```
```JSON
      {
        "data": [
          {
            "exchangeId": "Binance",
            "baseId": "bitcoin",
            "quoteId": "tether",
            "baseSymbol": "BTC",
            "quoteSymbol": "USDT",
            "volumeUsd24Hr": "277775213.1923032624064566",
            "priceUsd": "6263.8645034633024446",
            "volumePercent": "7.4239157877678087"
          },
          ...
        ],
        "timestamp": 1539289444052
      }
```

## Rates
```Ruby
data = Coincap::Rates.list
```
```JSON
      {
        "data": [
          {
            "id": "barbadian-dollar",
            "symbol": "BBD",
            "currencySymbol": "$",
            "type": "fiat",
            "rateUsd": "0.5000000000000000"
          },
        ...
        ],
        "timestamp": 1536347807471
      }
```

```Ruby
data = Coincap::Rates.single('bitcoin')
```
```JSON
      {
        "data": [
          {
            "id": "barbadian-dollar",
            "symbol": "BBD",
            "currencySymbol": "$",
            "type": "fiat",
            "rateUsd": "0.5000000000000000"
          },
        ...
        ],
        "timestamp": 1536347807471
      }
```

## Exchanges
```Ruby
data = Coincap::Exchanges.list
```
```JSON
      {
        "data": [
          {
            "id": "okex",
            "name": "Okex",
            "rank": "1",
            "percentTotalVolume": "21.379485735166293542000000000000000000",
            "volumeUsd": "616465445.1646260280799955",
            "tradingPairs": "22",
            "socket": false,
            "exchangeUrl": "https://www.okex.com/",
            "updated": 1536343139514
          },
        ...
        ],
        "timestamp": 1536605835421
      }
```

```Ruby
data = Coincap::Exchanges.single
```
```JSON
      {
        "data": {
          "id": "kraken",
          "name": "Kraken",
          "rank": "4",
          "percentTotalVolume": "2.946801735133553120000000000000000000",
          "volumeUsd": "84969370.4499608426167365",
          "tradingPairs": "52",
          "socket": false,
          "exchangeUrl": "https://kraken.com",
          "updated": 1536343139468
        },
        "timestamp": 1536605874069
      }
```

## Markets
```Ruby
data = Coincap::Markets.list
```
```JSON
    {
      "data": [
        {
          "exchangeId": "bitstamp",
          "rank": "1",
          "baseSymbol": "BTC",
          "baseId": "bitcoin",
          "quoteSymbol": "USD",
          "quoteId": "united-states-dollar",
          "priceQuote": "6927.3300000000000000",
          "priceUsd": "6927.3300000000000000",
          "volumeUsd24Hr": "43341291.9576547008000000",
          "percentExchangeVolume": "67.2199253376108585",
          "tradesCount24Hr": "420721",
          "updated": 1533581033590
        },
      ...
      ],
      "timestamp": 1533581173350
    }
```
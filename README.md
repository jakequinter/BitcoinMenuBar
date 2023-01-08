# BitcoinMenuBar

A simple MacOS menu bar application that hits the [Strike](https://strike.me/) API to retrieve current crypto prices and displays the latest Bitcoin price.

![CleanShot 2023-01-08 at 16 20 31](https://user-images.githubusercontent.com/39658269/211219678-8e32502d-c073-4611-a3b4-f80ffbb12572.gif)

## Setup

You will need to replace the STRIKE_API_KEY used in the `fetchStrikeAPI` [function call](https://github.com/jakequinter/BitcoinMenuBar/blob/main/BitcoinMenuBar/Views/ContentView.swift#L27).

There are a few different possibilities:

1. Hardcode your API key
2. Create an .env file
3. Use a .plist file
4. Create a struct with static keys you can reference in your code and add this file to your `.gitignore` file

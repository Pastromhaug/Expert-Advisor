Expert Advisor
=========================

Project Overview
----------------

 Finding a good trading strategy is a tricky business. ideally a trader must backtest the intended strategy on years of historical data, as well as months to years of real time data. When done manually, this takes forever. Even if the idea behind a strategy is good, if just one parameter is slightly unoptimal, the strategy can show abysmal results that would have been fantastic if just a small amount of tweaking was done. Luckily, the use of a trading programs called expert advisors can make this process much quicker and easier. 

Most expert advisors out there have a very narrow focus. They are built to test exactly one strategy, and allow for the optimization of a very limited number of parameters. The goals of this project is to develope an Expert Advisor which allows a user to customize a wide variety of parameters and settings for quick and easy backtesting, optimization, and live trading of a range of strategies. It is a collaboration between myself and an Uncle working in the Forex business who lacks a programming background. I work with him on defining exactly what he will need in the program, and design it to his specifications. 


Metatrade 4 setup
-----------------

Metatrader is a forex trading platform that can trade using coded algorithms called expert advisors. This software is designed to be run within Metatrader 4, and is coded in MQL4, a C++ based language developed by MetaQuotes oriented towards trading programs. The language documentation can be found here: http://book.mql4.com/ 

This program can only be run in Metatrader 4 build 600 or higher. To do any amount of trading, you must open either a real trading account or a demo account with a boker. I recommend Oanda, as they are free of charge for a demo account, and I have had a good experience with them thus far.	

Oanda account setup: https://fxtrade.oanda.com/your_account/fxtrade/register/gate

I am unsure about other brokers, but with Oanda you'll want to download their version of Metatrader 4 from their website once the account is created.  MT4 can also be downloaded from the metatrader website: http://www.metatrader4.com/. 

Investopedia has a good tutorial for familiarizing yourself with the Metatrader platform: http://www.investopedia.com/university/meta-trader-guide-intro/




Program Description and Instructions
-------------------------------------

The core strategy that this program is based off of is simple:
For a set of technical indicators, if all indicators are going up, buy. If all indicators are going down, sell.

Currently, In the latest version there are seven technical indicators that can be used invidivually or in combination with each other in this program. They are *Moving Average, Stochastic Oscillator, Stoch RSI Basic, THV3 T3, Babon Slope, THV T3 Trix, and AMA optimized*. Moving Average and Stochastic Oscillator are default indicators included in MT4, but the rest have to be downloaded and added manually.






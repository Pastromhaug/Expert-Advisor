Forex-algorithm-framework
=========================

The goals of this project is to develope an Expert Advisor which allows a user to customize a wide variety of
parameters and settings for quick and easy backtesting, optimization, and live trading of a range
of strategies. It is a collaboration between myself and an Uncle working in the Forex business who lacks a programming background. I work with him on defining exactly what he will need in the program, and design it to his specifications.

Metatrader is a forex trading platform that can trade using coded algorithms called expert advisors. This software is designed to be run within Metatrader 4, and is coded in MQL4, a C++ based language developed by MetaQuotes oriented towards trading programs. The language documentation can be found here: http://book.mql4.com/ 

 Finding a good trading strategy is a tricky business. ideally a trader must backtest the intended strategy on years of historical data, as well as months to years of real time data. When done manually, this takes forever. Even if the idea behind a strategy is good, if just one parameter is slightly unoptimal, the strategy can show abysmal results that would have been fantastic if just a small amount of tweaking was done. Luckily, the use of a trading programs called expert advisors can make this process much quicker and easier. 

Most expert advisors out there have a very narrow focus. They are built to test exactly one strategy, and allow for the optimization of a very limited number of parameters. This EA aims to allow for thorough customization of nearly every aspect of the strategy to maximize the chances of there being a profitable one within the framework. The core strategy that this program is based off of is simple:

For a set of technical indicators, if all indicators are going up, buy. If all indicators are going down, sell.

 


All coding has been done in MQL4, a C++ based language targeted towards trading
programs.
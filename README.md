Expert Advisor
=========================

Project Overview
----------------

Finding a good trading strategy is a tricky business. Ideally a trader must back test the intended strategy on years of historical data, as well as months to years of real time data. When done manually, this takes forever. Even if the idea behind a strategy is good, if just one parameter is slightly suboptimal, the strategy can show abysmal results that would have been fantastic if just a small amount of tweaking was done. Luckily, the use of a trading programs called expert advisors can make this process much quicker and easier. 

Most expert advisors out there have a very narrow focus. They are built to test exactly one strategy, and allow for the optimization of a very limited number of parameters. The goals of this project is to develop an Expert Advisor which allows a user to customize a wide variety of parameters and settings for quick and easy back testing, optimization, and live trading of a range of strategies. It is a collaboration between myself and an Uncle working in the Forex business who lacks a programming background. I work with him on defining exactly what he will need in the program, and design it to his specifications. 


Metatrader 4 setup
-----------------

Metatrader is a forex trading platform that can trade using coded algorithms called expert advisors. This software is designed to be run within Metatrader 4, and is coded in MQL4, a C++ based language developed by MetaQuotes oriented towards trading programs. The language documentation can be found here: http://book.mql4.com/ 

This program can only be run in Metatrader 4 build 600 or higher. To do any amount of trading, you must open either a real trading account or a demo account with a broker. I recommend Oanda, as they are free of charge for a demo account, and I have had a good experience with them thus far.	

Oanda account setup: https://fxtrade.oanda.com/your_account/fxtrade/register/gate

I am unsure about other brokers, but with Oanda you'll want to download their version of Metatrader 4 from their website once the account is created.  MT4 can also be downloaded from the metatrader website:
http://www.metatrader4.com/. 

Investopedia has a good tutorial for familiarizing yourself with the Metatrader platform:  
http://www.investopedia.com/university/meta-trader-guide-intro/




Program Description and Instructions
-------------------------------------

The core strategy that this program is based off of is simple:
For a set of technical indicators, if all indicators are going up, buy. If all indicators are going down, sell.

Currently, in the latest version there are seven technical indicators that can be used individually or in combination with each other in this program. They are *Moving Average, Stochastic Oscillator, Stoch RSI Basic, THV3 T3, Babon Slope, THV T3 Trix, and AMA optimized*. Moving Average and Stochastic Oscillator are default indicators included in MT4, but the rest have to be downloaded and added manually. 

When you load the EA onto a graph, the settings menu for the EA will look like this. The picture below shows all the indicators in the *Inputs* menu. Setting an indicator to *true* will enable that indicator when the EA is executed. The settings below each indicators shifted a few spaces to the right and that begin with a *>* character are the parameters that can be changed for each indicator. These just change how each indicator behaves.

![Top half of settings page](https://github.com/Pastromhaug/Expert-Advisor/blob/master/Untitled%20picture2.png)

The EA decides the direction of an indicator by looking at the last time that the indicator showed a positive or negative direction. If indicator is currently completely flat, the EA will look back at previous data until it finds a direction. The two possible directions are up or down. If all indicators are UP, then close all short positions and open a long position. If all indicators are DOWN, then close all long positions and open a short position. The EA will only ever have one open order, and will close it before opening the next order.

The only settings here under each indicator that aren't standard settings for that indicator are those called *% above direction doesn't change* and *% below direction doesn't change*. These can be found under *Stochastic Oscillator* and *Stoch RSI Basic*. All these mean are that the EA won't register a direction change in these indicators if the indicator is below the *% below direction doesn't change* value, or above the *% above direction doesn't change*. If you do not wish to use this functionality, set *% above direction doesn't change* to 100.0 and *% below direction doesn't change* to 0.0. 

The rest of the inputs can be found by scrolling down: 
![Bottom half of settings page](https://github.com/Pastromhaug/Expert-Advisor/blob/master/Untitl%20picture.png)

Here is a description of the rest of the variables:

**Entering method:** The value can be either *Directly* or *Wait for pullback*. If *Directly* is chosen, the EA will open orders immediately at the close of the last bar after the indicators change direction. In this case, you can ignore the four indented variables below. In this case, the four indented variables below can be ignored. If *Wait for pullback* is chosen, the EA will not open order, even if the buy signal changes, until a suitable pullback is detected. The pullback requirements are determined by the four indented settings below. The *Wait for pullback* option is still under development and should NOT be used.

**Take profit type:** This value cam be either *Constant* or *% ADR* or *None*. If you do not wish to use a take profit, select *None*, and ignore the three indented parameters below it. IF you wish to use a set number of pips above or below the price of the opened order as the take profit, select *Constant*. You must then set the indented **Constant** variable below to your desired number of pips. **% ADR** and **ADR: number of days** can be ignored in this case. If you wish to set your take profit to a number of pips equal to a desired % of ADR, select *% ADR*. The indented **% ADR** variable must then be set to the % of the ADR that you would like to use, and the **ADR: number of days** variable must be set to the number of days you wish the % ADR for the take profit to be calculated over.

**Stop loss type:** This value cam be either *Constant* or *% ADR* or *None*. If you do not wish to use a  
stop loss, select *None*, and ignore the three indented parameters below it. IF you wish to use a set number of pips above or below the price of the opened order as the stop loss, select *Constant*. You must then set the indented **Constant** variable below to your desired number of pips. **% ADR** and **ADR: number of days** can be ignored in this case. If you wish to set your stop loss to a number of pips equal to a desired % of ADR, select *% ADR*. The indented **% ADR** variable must then be set to the % of the ADR that you would like to use, and the **ADR: number of days** variable must be set to the number of days you wish the % ADR for the stop loss to be calculated over.

**if SL triggered, wait for direction change:** This variable can be set to *true* or *false*. If it is set to true, then if an order is closed on a stop loss, the program waits for all the indicators to switch directions before opening another order. 


**if TP triggered, wait for direction change:** This variable can be set to *true* or *false*. If it is set to true, then if an order is closed on a take profit, the program waits for all the indicators to switch directions before opening another order. 

**Max spread to trade (pips):** If the current spread is greater than this value, no orders are opened by the program.

**SL profit level type:** Can be set to *None*, *Constant*, or *% ADR*. If set to *Constant*, if the price moves favorably while an open position is held (up if it is an long position, down if it is a short position), and it moves past the price that the order was opened at +/- the value under the indented **Constant** variable (depending on the position), the program resets the stop loss to a price determined by the **BE/SL level type** below. If it is set to *% ADR*, this variable has the same function, but instead of using a constant to determine the price level at which, if the price crosses, a new stop loss is set, uses a % ADR determined by the indented **% ADR** variable and the **ADR: number of days** settings. If *Constant* is selected, then the indented **% ADR** and **ADR: number of days** variables will be ignored, and if *% ADR* is selected, the indented variable **Constant** will be ignored.

**BE/SL level type:** If **SL profit level type** is not set to *None* and the price crosses the line determined by the **SL profit level type** block while an open position is held, the program will change the stop loss of the open order to a price dependent on the setting of this variable. The change in stop loss is made relative to the price crossed that was set by the **SL profit level type** variable.

**Day not to trade:** There are six of these. Each can be set to any day of the week or *None*. The program will not open any orders on the days specified by these variables.

**Trade around the clock?** This variable determines if the program can open orders at all times of the day if *true*, or whether it can only open orders during the times specified by the **Hour to start trading**, **Minute to start trading**, **Hour to stop trading**, and **Minute to stop trading** variables below if set to *false*. **Hour to start trading, Minute to start trading, Hour to stop trading, Minute to stop trading:** Determine the times during the day that the EA can open positions. The time *xx:xx* set by the first two variables must be earlier in the day than the time set by the last two.

**Day to close all trades, Hour to close all trades, Minute to close all trades:** These variables decide a day, hour, and minute that the program closes all open orders. If *Day to close all trades** is set to *None* then the other two are ignored and the program does not have a weekly time where all positions are closed.

**Start trading immediately/Wait for direction change:** If *Wait for direction change* is selected, then every day when trading begins, the program waits for the indicators to switch directions before opening any trades. If *Start trading immediately* is selected, then this does not happen. This variable is ignored if **Trade around the clock?** is set to *true*.

**lot_size_const:** Determines the number of lots to be committed in every open position.

**max slippage (pips):** If the price changes by this many pips between the time the EA sends out an order to open a position, and the trading terminal is actually ready to execute the order, terminate the order.


Future Work
-----------

-  Every aspect of this program must be more thoroughly tested before it should be used for trading, optimization, and testing purposes.

-  Complete implementation of the *Wait for pullback* option under the **Entering method** variable. This is an essential feature for making any strategy profitable. The program must be able to accurately detect a good pullback in order to open trades with better timing.

-  Implement a feature where instead of only waiting for all indicators to change directions if the **If SL triggered, wait for direction change, If TP triggered, wait for direction change,** or **start trading immediately/Wait for direction change** are set to wait for a direction change, allow the user to choose specific indicators that will be watched for a direction change before opening positions is allowed.

-  Extensive code optimization. This EA is designed to be tested on years of historical data hundreds or thousands of times simultaneously when optimizing a wide variety of parameters. It is important that the code runs quickly so that this process doesn't take forever.

-  More robust error handling. For optimization and trading on demo account, fairly simple error handling will suffice. However, if real money is to be put on the line using this program, much more work will have to be done on making an extensive and thorough error handling system.

-  More indicators will likely be added in order to make the program more flexible. 







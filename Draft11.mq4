//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

#property strict
#import  "stdlib.ex4"
string ErrorDescription(int error_code);
#import

//------------------------------Indicators--------------------------------------------------------------// 
//--- Moving Average
sinput bool use_moving_average=           False;   // Moving Average
input int ma_period1 =                    0;       //>   Period 
input int ma_shift1 =                     0;       //>   MA shift
input ENUM_MA_METHOD MAmethod;                     //>   Averaging method
input ENUM_APPLIED_PRICE p_constant;               //>   Applied price

//--- Stochastic Oscillator
sinput bool use_stoch_oscillator=         false;   // Stochastic Oscillator
input int Kperiod =                       0;       //>   K line period
input int Dperiod =                       0;       //>   D line period  
input int slowing =                       0;       //>   Slowing
input ENUM_MA_METHOD StochAvMethod;                //>   Averaging method
input ENUM_STO_PRICE p_field;                      //>   Price
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
enum ENUM_ISTOCH_MODE
  {
   mode_main = 0,                                  // Base indicator line
   mode_signal = 1,                                // Signal line
  };
input ENUM_ISTOCH_MODE istoch_mode;                //>   Line index
input double aboveNoChangeStoch =         0;    //>   % above direction doesn't change
input double belowNochangeStoch =         0;    //>   % above direction doesn't change

//--- THV3 T3
sinput bool use_THV3T3=                   false;   // THV3 T3
input int THV_MA_period =                 250;     //>   MA period
input double b =                          .4;      //>   b (hva er dette?)

//--- Babon Slope   
sinput bool use_babon_slope=              false;   // Babon Slope
input int BS_period =                     0;       //>   Period
input ENUM_MA_METHOD BS_MA_method;                 //>   MA method
input ENUM_APPLIED_PRICE BS_p_constant;            //>   Applied price

//--- THV T3 Trix
sinput bool use_THVT3_Trix=               false;   // THV T3 Trix
input int TrixNumBars =                   0;       //>   Trix number of bars
input int A_t3_period =                   0;       //>   A t3 period
input int B_t3_period_AC =                0;       //>   B t3 period AC

//--- Stochastic RSI basic
sinput bool use_stoch_RSI_basic=false;   // Stoch RSI basic
input ENUM_APPLIED_PRICE RSI_Rprice;               //>   Applied price
input int RSI_Rperiod =                   0;       //>   R period
input int RSI_Kperiod =                   0;       //>   K period
input int RSI_Dperiod =                   0;       //>   D period
input int RSI_slowing =                   0;       //>   slowing
input double aboveNoChangeRSIbasic =     85.0;     //>   % above direction doesn't change
input double belowNoChangeRSIbasic =     15.0;     //>   % below direciont doesn't change

//--- AMA optimized
sinput bool use_AMA_optimized=            false;   // AMA optimized
input int periodAMA =                     10;      //>   AMA period
input double nfast =                      2.0;     //>   nfast
input double nslow=                      30.0;     //>   nslow
input double G =                          2.0;     //>   G
input double dK =                         2.0;     //>   dK
input ENUM_APPLIED_PRICE PriceType;                //>   Applied Price
input int AMA_trend_type =                1;       //>   Trend type
//----------------------------------Entering--------------------------------------------------------------// 
enum how_enter
  {
   enter_directly = 0,                                // Directly
   enter_pullback = 1,                                // Wait for pullback
  };
input how_enter enter_method=enter_directly;          // Entering method

enum constant_or_adr
   {
   constant = 0,                                      // Constant
   adr = 1,                                           // % ADR
   none = 2,                                          // None
   };
enum pull_type
   {
    use_bars = 0,                                     // Bars
    use_minutes = 1,                                  // Minutes
   };
//---------------------------------Pullbacks--------------------------------------------------------------//
sinput pull_type pullback_type= use_bars;             //>   Use minutes/bars for pullback 
input double pbRetracePercent =              0.0;     //>   Retracement %
input int pbRetraceBars =                    0;       //>   Num bars/min for high/low 
input int pbMaxBars =                        0;       //>   Num bars/min back pullback can start
//input int pbRetraceTime =                    0;       //>   Num minutes for high/low 
//input int pbMaxTime =                        0;       //>   Num minutes back pullback can start

//---------------------------------Take Profit------------------------------------------------------------// 
sinput constant_or_adr TP_const_adr=         constant;   // Take profit type
input double t_prof_const=0.0;                           //>   Constant
input double t_prof_ADR =                    0.0;        //>   % ADR 
input int tpADR_NumDays             =        0;          //>   ADR: number of days

//-----------------------------------Stop Loss------------------------------------------------------------// 
sinput constant_or_adr  SL_const_adr=        constant;   // Stop loss type
input double s_loss_const=0.0;                           //>   Constant
input double s_loss_ADR =                    0.0;        //>   % ADR
input int slADR_NumDays =                    0;          //>   ADR: number of days          
sinput bool use_SL_trigger =                 True;       // If SL triggered, wait for direction change
sinput bool use_TP_trigger =                 True;       // If TP triggered, wait for direction change
input int max_spread_allowed =               0;          // Max spread to trade (pips)
sinput constant_or_adr SL_profit_lvl_type=   none;       // SL profit level type
input double sl_prof_lvl_const=              0.0;        //>   Constant
input double sl_prof_lvl_pADR=               0.0;        //>   % ADR
input int sl_prof_lvl_daysADR=               0;          //>   ADR: number of days
sinput constant_or_adr BE_SL_lvl_type=       none;       // BE/SL level type
input double BE_SL_lvl_const=                0.0;        //>   Constant
input double BE_SL_lvl_pADR=                 0.0;        //>   % ADR
input int BE_SL_lvl_daysADR=                 0;          //>   ADR: number of days
//------------------------------------Date and Times------------------------------------------------------//

enum days
  {
   noday = 7,                                         // None
   monday = MONDAY,                                   // Monday
   tuesday = TUESDAY,                                 // Tuesday
   wednesday = WEDNESDAY,                             // Wednesday
   thursday = THURSDAY,                               // Thursday
   friday = FRIDAY,                                   // Friday
   saturday = SATURDAY,                               // Saturday
   sunday = SUNDAY,                                   // Sunday
  };
input days day1notrade =   noday;                     // Day not to trade
input days day2notrade =   noday;                     // Day not to trade
input days day3notrade =   noday;                     // Day not to trade
input days day4notrade =   noday;                     // Day not to trade
input days day5notrade =   noday;                     // Day not to trade
input days day6notrade =   noday;                     // Day not to trade

sinput bool trade_around_clock =  false;              // Trade around the clock?             
input int hour_start =           0;                   // Hour to start trading
input int min_start =            0;                   // Minute to start trading
input int hour_stop =            0;                   // Hour to stop trading
input int min_stop =             0;                   // Minute to stop trading

input days dayCloseTrades = friday;                   // Day to close all trades
input int hourCloseTrades = 0;                        // Hour to close all trades
input int minCloseTrades = 0;                         // Minute to close all trades
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
enum waitOrGo
  {
   goFirst = 0,                                       // Start trading immediately
   waitFirst = 1,                                     // Wait for direction change
  };
input waitOrGo startWaitOrGo=goFirst;                 // start trading Immediately/Wait for direction change    

bool trade_on_day;
bool trade_on_time;

//----------------------------------Direction Constants---------------------------------------------------// 
const int UP=0;
const int DOWN=1;
const int NODIR=2;

const int BUY=0;
const int SELL =     1;
const int WAIT =     2;

const int MA=0;
const int STOCH_OSC=1;
const int THV3_T3=2;
const int STOCH_RSI_BASIC=3;
const int BABON_SLOPE=4;
const int THV3_T3_TRIX=5;
const int AMA_OPTIMIZED=6;

int MA_direction;
int Stoch_Osc_direction;
int Stoch_Osc_MA_direction;
int Stoch_RSI_basic_direction;
int first_direction;
bool order_opened;
int errornum;

//--------------------------------------Lot Size Constants------------------------------------------------// 
input double lot_size_const=0.0;

//-----------------------------------Arrays---------------------------------------------------------------// 
bool  AllIndicators[7];
int   ActiveIndicators[100];
int   ActiveIndiDirections[];
double  opened_tickets_history[1][6]; //contains all tickets that have been opened since start of EA
// opened_tickets_history[][0] - ticket number
// opened_tickets_history[][1] - ADR used in SL profit calculation
// opened_tickets_history[][2] - pips used for SL profit calculation
// opened_tickets_history[][3] - ADR used in BE/SL calculation
// opened_tickets_history[][4] - pips used for BE/SL
// opened_tickets_history[][5] - 0 if order has NOT been modified, 1 if order HAS been modified 

//-----------------------------------Other Variables/Constants--------------------------------------------// 
int   activeIndicators;
int trade_signal=WAIT;
int first_trade_signal;
bool trade_signal_changed;
const int MAGICNUMBER=070795;
input int slippage=0;            //max slippage (pips)
bool pullback;
bool SL_triggered;
bool TP_triggered;
bool below_max_spread;
bool good_to_trade;
bool externcheck;
datetime lastBarTime;
datetime curBarTime;
int lasClosedOrder;
int curClosedOrder;
bool SL_occured;
bool TP_occured;
bool SL_TP_stop;
bool new_bar;

//-----------------------------------ADR------------------------------------------------------------------// 

double ADRtoday;
double ADRalldays;
double pnt=MarketInfo(Symbol(),MODE_POINT);
int dig=(int)MarketInfo(Symbol(),MODE_DIGITS);
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   externcheck=true;
   check_all_externs();
   if(externcheck==false)
     {
      Alert("EA will not execute. Restart EA and correct inputs.");
      return(INIT_FAILED);
     }
// Initialize vvarious variables
   lastBarTime=     Time[0];
   curBarTime =      Time[0];
   lasClosedOrder= 0;
   curClosedOrder= 0;
   SL_occured =      false;
   TP_occured =      false;
   SL_TP_stop =      false;
   pullback=false;
   externcheck=true;
   trade_on_day=true;
   trade_on_time=   true;
   MA_direction =               NODIR;
   Stoch_Osc_direction=NODIR;
   Stoch_Osc_MA_direction=NODIR;
   Stoch_RSI_basic_direction=NODIR;
   new_bar= false;
// Sets the arrayto store every indicator's true/false status
   AllIndicators[MA]=use_moving_average;
   AllIndicators[STOCH_OSC]=use_stoch_oscillator;
   AllIndicators[THV3_T3]=use_THV3T3;
   AllIndicators[STOCH_RSI_BASIC]=use_stoch_RSI_basic;
   AllIndicators[BABON_SLOPE]=use_babon_slope;
   AllIndicators[THV3_T3_TRIX]=use_THVT3_Trix;
   AllIndicators[AMA_OPTIMIZED]=use_AMA_optimized;

// Increments through AllIndicators to find the number of indicators
// that are turned on and adds them to ActiveIndicators
   activeIndicators=0;
   for(int i=0; i<ArraySize(AllIndicators); i++)
     {
      if(AllIndicators[i]==true)
        {
         ActiveIndicators[activeIndicators]=i;
         activeIndicators++;
        }
     }
   ArrayResize(ActiveIndicators,activeIndicators);

// Making ActiveIndiDirections big enough to add all the directions to
// this array in OnTick()  
   ArrayResize(ActiveIndiDirections,activeIndicators);

// Set initial trade_signal value
   init_trade_signal();

// set pnt in case the broker uses 3 or 5 decimals for the currency pair
   if(dig==3 || dig==5) pnt*=10;
   
   errornum = GetLastError();
      if(errornum != 0)
         {
          string errorstring=ErrorDescription(errornum);
          Alert("---Bottom of OnInit error: ",errornum,". ",errorstring);
         }
      else Alert("Bottom of OnInit. Error occured but no error was recorded.");
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   closeAllTrades();
   errornum = GetLastError();
      if(errornum != 0)
         {
          string errorstring=ErrorDescription(errornum);
          Alert("---Bottom of OnDeinit error: ",errornum,". ",errorstring);
         }
   Print("EA de-initialized");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()

  {
   errornum = GetLastError();
      if(errornum != 0)
         {
          string errorstring=ErrorDescription(errornum);
          Alert("---Top of OnTick. error: ",errornum,". ",errorstring);
         }
/**----------------------------------------------------------------------------------- Section 1
        1. Trade Signals . Receiving trade signals
        a) Every tick                       
        b) Every bar of the given timeframe     
        OP_BUY      - to buy
        OP_SELL     - to sell
        OP_BALANCE  - no signal
*/

//creates an array of open orders (should only be one order at a time)
   double Tickets[20][10];
// Tickets[][0] - ticket number
// Tickets[][1] - order type
// Tickets[][2] - lots
// Tickets[][3] - open price
// Tickets[][4] - Stop Loss
// Tickets[][5] - TakeProfit
// Tickets[][6] - MagicNumber
// Tickets[][7] - expiration time
// Tickets[][8] - open time
   setTickets(Tickets); //Fills the Tickets[][] array

   new_bar= is_first_tick_in_bar();
   if(new_bar == true)
      {
// takes the indicators in ActiveIndicators[] and puts them in 
// array ActiveIndiDirections[]
       setActiveIndiDirections(1,2);
// changes trade_signal to either BUY (0), SELL (1) or WAIT (2)
// if all indicators go UP,  trade_signal == BUY... DOWN > SELL, or WAIT if neigher.
   //trade_signal=WAIT;
       set_trade_signal();
      }
/**----------------------------------------------------------------------------------- Section 2
        2.
        a) Calculate OpenPrice, SL, TP, and Lots for a new order
*/
// calculating SL pips
   double tpADR,slADR,tpPips,slPips;
   if(SL_const_adr == adr)
     {
      slADR=calc_ADR(slADR_NumDays);
      slPips=slADR*pnt*s_loss_ADR/100;
     }
   else if (SL_const_adr == constant)
      {
       slPips=s_loss_const*pnt;
      }
// calculating TP pips
   if(TP_const_adr == adr)
     {
      tpADR=calc_ADR(tpADR_NumDays);
      tpPips=tpADR*pnt*t_prof_ADR/100;
     }
   else if (TP_const_adr == constant)
      {
       tpPips=t_prof_const*pnt;
      }
// calculating TP and SL exact values
   double SL, TP;
   if(trade_signal==BUY)
      {
       if (SL_const_adr == none) SL = 0.0;
       else SL = Ask-slPips;
       if (TP_const_adr == none) TP = 0.0;
       else TP = Ask+tpPips;
      }
   else if(trade_signal==SELL)
      {
       if (SL_const_adr == none) SL = 0.0;
       else SL = Bid+slPips;
       if (TP_const_adr == none) TP = 0.0;
       else TP = Bid-tpPips;
      }
   
// finding ADR numbers for modifying stop loss of an open order
   double SL_prof_lvl_ADR= 0;
   double SL_prof_lvl_pips= 0;
   if (SL_profit_lvl_type == adr)
      {
      SL_prof_lvl_ADR = calc_ADR(sl_prof_lvl_daysADR);
      SL_prof_lvl_pips = SL_prof_lvl_ADR*sl_prof_lvl_pADR/100;
      }
   else if (SL_profit_lvl_type == constant)
      {
      SL_prof_lvl_pips = sl_prof_lvl_const;
      }
   double BE_SL_ADR= 0;
   double BE_SL_pips= 0;
   if (SL_profit_lvl_type != none && BE_SL_lvl_type == adr)
      {
      BE_SL_ADR = calc_ADR(BE_SL_lvl_daysADR);
      BE_SL_pips = BE_SL_ADR*BE_SL_lvl_pADR/100;
      }
   else if (SL_profit_lvl_type != none && BE_SL_lvl_type == constant)
      {
      BE_SL_pips = BE_SL_lvl_const;
      }

// Lots for new order
   double lotDollars=AccountLeverage()*lot_size_const*AccountEquity();
   double lotSize=lotDollars/(100000);
   
// Appending append_opened_tickets[][]
   if(order_opened == true)
      {
      for(int i = 0; i<ArrayRange(Tickets,0); i++)
         {
         append_opened_tickets_history((int)Tickets[i][0], errornum, SL_prof_lvl_ADR, SL_prof_lvl_pips, BE_SL_ADR, BE_SL_pips);
         }
      }
// Actually modifying open order SL
   if(SL_profit_lvl_type != none)
      {
      modify_orders(Tickets);
      }
/**----------------------------------------------------------------------------------- Section 3
      3. 
        a) Close open order by signal        
*/
// Clolsing orders by signal

   if(trade_signal==BUY)
      for(int i=0; i<ArrayRange(Tickets,0); i++)
        {
         if(Tickets[i][1]==OP_SELL && OrderSelect((int)Tickets[i][0],SELECT_BY_TICKET,MODE_TRADES))
           {
            bool orderClosed;
            orderClosed=OrderClose((int)Tickets[i][0],Tickets[i][2],Ask,slippage);
            if(orderClosed==false)
              {
               errornum = GetLastError();
               if(errornum != 0)
                 {
                  string errorstring=ErrorDescription(errornum);
                  Alert("Error closing BUY order : ",errornum,". ",errorstring);
                 }
               else Alert("BUY order didn't close but no error was recored.");
              }
           }
        }
   else if(trade_signal==SELL)
   for(int i=0; i<ArrayRange(Tickets,0); i++)
     {
      if(Tickets[i][1]==OP_BUY && OrderSelect((int)Tickets[i][0],SELECT_BY_TICKET,MODE_TRADES))
        {
         bool orderClosed;
         orderClosed=OrderClose((int)Tickets[i][0],Tickets[i][2],Bid,slippage);
         if(orderClosed==false)
           {
            errornum = GetLastError();
            if(errornum != 0)
              {
               string errorstring=ErrorDescription(errornum);
               Alert("Error closing SELL order : ",errornum,". ",errorstring);
              }
            else Alert("SELL order didn't close but no error was recored.");
           }
        }
     }

/**----------------------------------------------------------------------------------- Section 4
      4. 
        a) Open an order at the market price 
*/ 
   errornum = 0;
   int ticket = 0;
   if(good_to_trade()==true)
     {
      if(trade_signal==BUY)
        {
         ticket=OrderSend(NULL,OP_BUY,lotSize,Ask,slippage,SL,TP,NULL,MAGICNUMBER,0,Blue);
         if(ticket<=0)
           {
            errornum = GetLastError();
            if(errornum != 0)
              {
               string errorstring=ErrorDescription(errornum);
               Alert("Error opening BUY order : ",errornum,". ",errorstring);
              }
            else Alert("BUY order didn't open but no error was recorded.");
           }
        }
      else if(trade_signal==SELL)
        {
         ticket=OrderSend(NULL,OP_SELL,lotSize,Bid,slippage,SL,TP,NULL,MAGICNUMBER,0,Red);
         if(ticket<=0)
           {
            errornum = GetLastError();
            if(errornum != 0)
              {
               string errorstring=ErrorDescription(errornum);
               Alert("Error opening SELL order : ",errornum,". ",errorstring);
              }
            else Alert("SELL order didn't open but no error was recorded.");
           }
        }
     }
   if(ticket > 0)
      {
      order_opened=true;
      }
   else order_opened=false;
   errornum = GetLastError();
      if(errornum != 0)
         {
          string errorstring=ErrorDescription(errornum);
          Alert("---Bottom of OnTick error: ",errornum,". ",errorstring);
         }
  }
  
//+------------------------------------------------------------------+
//| My Functions                                                     |
//+------------------------------------------------------------------+

//---------------------------------Methods for determening indicator direction----------------------------------//
//--- Returns the direction of the MA. 0 = up, 1 = down, 2 = flat.
void display_error(string function)
   {
   errornum = GetLastError();
      if(errornum != 0)
         {
          string errorstring=ErrorDescription(errornum);
          Alert(function,"()  error: ",errornum,". ",errorstring);
         }
    }
int MA_direction(int bar_A,int bar_B)
  {
   if(bar_B >= Bars-1)
      {
       //Alert("Out of graph range. No direction found for MA.");
       return(NODIR);
      }
   double bar0 = iMA(NULL, 0, ma_period1, ma_shift1, MAmethod, p_constant, bar_A);
   double bar1 = iMA(NULL, 0, ma_period1, ma_shift1, MAmethod, p_constant, bar_B);
   double diff = bar0 - bar1;
   if(diff > 0)        return(UP);
   else if(diff < 0)   return(DOWN);
   else
     {
      return(MA_direction(bar_A+1,bar_B+1));
     }
  display_error(__FUNCTION__);
  }
//--- Direction of Stochastic Oscillator   
int Stoch_Osc_direction(int bar_A,int bar_B)
  {
   if(bar_B >= Bars)
      {
       //Alert("Out of graph range. No direction found for Stoch Osc.");
       return(NODIR);
      }
   double bar0 = iStochastic(NULL, 0, Kperiod, Dperiod, slowing, StochAvMethod, p_field, istoch_mode, bar_A);
   double bar1 = iStochastic(NULL, 0, Kperiod, Dperiod, slowing, StochAvMethod, p_field, istoch_mode, bar_B);
   if(bar0 > aboveNoChangeStoch || bar0 < belowNochangeStoch) return(Stoch_Osc_direction);
   double diff=bar0-bar1;
   if(diff > 0)        return(UP);
   else if(diff < 0)   return(DOWN);
   else
     {
      return(Stoch_Osc_direction(bar_A+1,bar_B+1));
     }
  display_error(__FUNCTION__);
  }
//--- Direction of Babon Slope  
int Babon_Slope_direction(int bar_A,int bar_B)
  {
   if(bar_B >= Bars)
      {
       //Alert("Out of graph range. No direction found for Babon Slope.");
       return(NODIR);
      }
   double bar0 = iCustom(NULL, 0, "Babon Slope ", BS_period, BS_MA_method, BS_p_constant, 2, bar_A);
   double bar1 = iCustom(NULL, 0, "Babon Slope ", BS_period, BS_MA_method, BS_p_constant, 2, bar_B);
   double diff = bar0- bar1;
   if(diff > 0)        return(UP);
   else if(diff < 0)   return(DOWN);
   else
     {
      return(Babon_Slope_direction(bar_A+1,bar_B+1));
     }
  display_error(__FUNCTION__);
  }
//--- Direction of THV3 T3
int THV3_T3_direction(int bar_A,int bar_B)
  {
   if(bar_B >= Bars)
      {
       //Alert("Out of graph range. No direction found for THV3 T3.");
       return(NODIR);
      }
   double bar0 = iCustom(NULL, 0, "THV3 T3(1)", THV_MA_period, b, 0, bar_A);
   double bar1 = iCustom(NULL, 0, "THV3 T3(1)", THV_MA_period, b, 0, bar_B);
   double diff = bar0 - bar1;
   if(diff > 0)        return(UP);
   else if(diff < 0 )  return(DOWN);
   else
     {
      return(THV3_T3_direction(bar_A+1,bar_B+1));
     }
   display_error(__FUNCTION__);
  }
//--- Direction of Stochastic RSI Basic  
int Stoch_RSI_Basic_direction(int bar_A,int bar_B)
  {
   if(bar_B >= Bars)
      {
       //Alert("Out of graph range. No direction found for Stoch RSI Basic.");
       return(NODIR);
      }
   double bar0 = iCustom(NULL, 0, "StochRSI_basic", RSI_Rprice, RSI_Rperiod, RSI_Kperiod, RSI_Dperiod, RSI_slowing, 1, bar_A);
   double bar1 = iCustom(NULL, 0, "StochRSI_basic", RSI_Rprice, RSI_Rperiod, RSI_Kperiod, RSI_Dperiod, RSI_slowing, 1, bar_B);
   if(bar0 > aboveNoChangeRSIbasic || bar0 < belowNoChangeRSIbasic) return(Stoch_RSI_basic_direction);
   double diff=bar0-bar1;
   if(diff > 0)        return(UP);
   else if(diff < 0)   return(DOWN);
   else
     {
      return(Stoch_RSI_Basic_direction(bar_A+1,bar_B+1));
     }
   display_error(__FUNCTION__);
  }
//--- Direction of THV T3 Trix
int THV_T3_Trix_direction(int bar_A,int bar_B)
  {
   if(bar_B >= Bars)
      {
       //Alert("Out of graph range. No direction found for THV T3 Trix.");
       return(NODIR);
      }
   double bar0 = iCustom(NULL, 0, "THV T3 Trix", TrixNumBars, A_t3_period, B_t3_period_AC, 1, bar_A);
   double bar1 = iCustom(NULL, 0, "THV T3 Trix", TrixNumBars, A_t3_period, B_t3_period_AC, 1, bar_B);
   double diff = bar0 - bar1;
   if(diff > 0)        return(UP);
   else if(diff < 0 )  return(DOWN);
   else
     {
      return(THV_T3_Trix_direction(bar_A+1,bar_B+1));
     }
   display_error(__FUNCTION__);
  }
//--- Direction of AMA Optimized
int AMA_optimized_direction(int bar_A)
  {
   if(bar_A >= Bars)
      {
       //Alert("Out of graph range. No direction found for AMA optimized.");
       return(NODIR);
      }
   double barUp=iCustom(NULL,0,"AMA_optimized",periodAMA,nfast,nslow,G,dK,PriceType,AMA_trend_type,1,bar_A);
   double barDown=iCustom(NULL,0,"AMA_optimized",periodAMA,nfast,nslow,G,dK,PriceType,AMA_trend_type,2,bar_A);
   if(barUp != 0 && barDown == 0)        
      {
       //Alert("---UP");
       return(UP);
      }
   else if(barDown != 0 && barUp == 0)   
      {
       //Alert("---DOWN");
       return(DOWN);
      }
   else
     {
      //Alert("---recursive");
      return(AMA_optimized_direction(bar_A+1));
     }
   display_error(__FUNCTION__);
  }
//--- Decides whether it is time to close all orders according to the settings
void closeAllTradesOnTime()
   {
   datetime todaydt=TimeLocal();
   MqlDateTime mqldt;
   TimeToStruct(todaydt,mqldt);
   int dayLocal=mqldt.day;
   int hourLocal=mqldt.hour;
   int minuteLocal=mqldt.min;
   if(dayCloseTrades == dayLocal && dayCloseTrades != noday)
      {
      if(hourLocal > hourCloseTrades)
         {
         Print("Closing all open positions.");
         closeAllTrades();
         }
      else if(hourLocal == hourCloseTrades)
         {
         if(minuteLocal >= minCloseTrades)
            {
            Print("Closing all open positoins.");
            closeAllTrades();
            }
         }
         
      }
    display_error(__FUNCTION__);
   }
//--- Closes all open positions
void closeAllTrades()
   {
   double Tickets[20][9];
// Tickets[][0] - ticket number
// Tickets[][1] - order type
// Tickets[][2] - lots
// Tickets[][3] - open price
// Tickets[][4] - Stop Loss
// Tickets[][5] - TakeProfit
// Tickets[][6] - MagicNumber
// Tickets[][7] - expiration time
// Tickets[][8] - open time

   setTickets(Tickets); //Fills the Tickets[][] array
   for(int i=0; i<ArrayRange(Tickets,0); i++)
     {
      if(Tickets[i][1]==OP_SELL)
        {
         bool orderClosed;
         orderClosed=OrderClose((int)Tickets[i][0],Tickets[i][2],Ask,slippage);
         if(orderClosed==false)
           {
            errornum = GetLastError();
            if(errornum != 0)
              {
               string errorstring=ErrorDescription(errornum);
               Alert(__FUNCTION__," Error closing BUY order : ",errornum,". ",errorstring);
              }
            else Alert(__FUNCTION__," BUY order didn't close but no error was recored.");
           }
        }
      if(Tickets[i][1]==OP_BUY)
        {
         bool orderClosed;
         orderClosed=OrderClose((int)Tickets[i][0],Tickets[i][2],Bid,slippage);
         if(orderClosed==false)
           {
            errornum = GetLastError();
            if(errornum != 0)
              {
               string errorstring=ErrorDescription(errornum);
               Alert(__FUNCTION__," Error closing SELL order : ",errornum,". ",errorstring);
              }
            else Alert(__FUNCTION__," SELL order didn't close but no error was recored.");
           }
        }
     }
    display_error(__FUNCTION__);
   }
//--- Modifies the SL of orders that go above a certain threshold specified by inputs
void modify_orders(double &Tickets[][])  
   {
   //Alert("size of Tickets: ", ArrayRange(Tickets, 0));
   for(int i = 0; i < ArrayRange(Tickets, 0); i++)
      {
      //Alert("first for loop");
      int aticket = (int)Tickets[i][0];
      if(aticket == 0) 
         {
         Alert(__FUNCTION__," error: aticket == 0");
         continue;
         }
      else if(aticket < 0)
         {
         Alert(__FUNCTION__," Error in modify_open_SL(): ticket selected is < 0.");
         continue;
         }
      //Alert("aticket is good");
      if (!OrderSelect(aticket, SELECT_BY_TICKET, MODE_TRADES))
         {
         Alert(__FUNCTION__," Error in modify_open_SL(): OrderSelect() failed for ticket in Tickets[][].");
         return;
         }
      //Alert("---aticket order selected: ", aticket);
      int oth_size= ArrayRange(opened_tickets_history, 0);
      //Alert("---oth_size: ", oth_size);
      //Alert("---opened_tickets_history[oth_size-1][0] = ", opened_tickets_history[oth_size-1][0]);
      int oth_index = -1;
      for(int j=(oth_size-1); i>=0; i--)
         {
         //Alert("---for(int j=(oth_size-1); i>=0; i--)");
         if(opened_tickets_history[j][0] == aticket)
            {
            //Alert("---if(opened_tickets_history[j][0] == aticket");
            oth_index = j;
            break;
            }
         }
      if(oth_index == -1) 
         {
         //Alert(__FUNCTION__," error in modify_open_SL(): oth_index == -1)");
         return;
         }
      double ticket_SL_prof_pips= opened_tickets_history[oth_index][2];
      double ticket_BE_SL_pips= opened_tickets_history[oth_index][4];
      double ticketOpenPrice = NormalizeDouble(Tickets[i][3], dig);
      int ticketType = (int)Tickets[i][1];
      double price_for_modify;
      int ticket_already_modified= (int)opened_tickets_history[oth_index][5];
      if(ticket_already_modified == 0)
         {
         //Alert("if(ticket_already_modified == 0");
         if(ticketType == OP_BUY)
            {
            //Alert("if(ticketType == OP_BUY)");
            price_for_modify= ticketOpenPrice+(ticket_SL_prof_pips*pnt);
            if(Ask >= price_for_modify)
               {
               //Alert("if(Ask >= price_for_modify)");
               double new_SL= ticketOpenPrice+(ticket_BE_SL_pips*pnt);
               double ticketTakeProfit= Tickets[i][5];
               //Alert(__FUNCTION__," ticket_BE_SL_pips: ", ticket_BE_SL_pips);
               if(!OrderModify(aticket, ticketOpenPrice, new_SL, ticketTakeProfit, OrderExpiration()))
                  {
                  //Alert(__FUNCTION__," error modifying order ", aticket);
                  break;
                  }
               Tickets[i][4]= new_SL; 
               opened_tickets_history[oth_index][5]= 1;
               Alert(__FUNCTION__," Order ", aticket, " modified.");
               }
            }
         else if(ticketType == OP_SELL)
            {
            //Alert("if(ticketType == OP_SELL)");
            price_for_modify= ticketOpenPrice-(ticket_SL_prof_pips*pnt);
            if(Bid <= price_for_modify)
               {
               //Alert("if(Bid <= price_for_modify)");
               double new_SL= ticketOpenPrice-(ticket_BE_SL_pips*pnt);
               double ticketTakeProfit= Tickets[i][5];
               //Alert(__FUNCTION__," ticket_BE_SL_pips: ", ticket_BE_SL_pips);
               if(!OrderModify(aticket, ticketOpenPrice, new_SL, ticketTakeProfit, OrderExpiration()))
                  {
                  //Alert(__FUNCTION__," error modifying order ", aticket);
                  break;
                  }
               Tickets[i][4]= new_SL;
               opened_tickets_history[oth_index][5]= 1;
               //Alert(__FUNCTION__,"  Order ", aticket, " modified.");
               }
            }
         else
           {
            Alert(__FUNCTION__," error: ticket ", aticket, " being modified is not OP_SELL or OP_BUY");
            break;
           }
         }
      }
    display_error(__FUNCTION__);  
   }   
//--- appends the last opened order and the ADR values used for SL change calculations
//--- to the end of opened_tickets_history[][2]
void append_opened_tickets_history(int ticket, int numerror, double SL_prof_ADR, double SL_prof_pips, double BE_SL_ADR, double BE_SL_ADR_pips)
   {
   if(numerror != 0)
      {
       Alert(__FUNCTION__," ticket ", ticket, " not added to opened_tickets_history[][] due to error.");
       return;
      }
   if(!OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
      {
       Alert(__FUNCTION__," ticket ", ticket, " not added to opened_tickets_history[][] due to OrderSelect failure.");
       return;
      }
   int oth_size = ArrayRange(opened_tickets_history, 0);
   if(oth_size != 1)
      {
       Alert(__FUNCTION__," Array open_tickets_history does not have size of 1.");
      }
   /*  
   if(oth_size > 1)
      {
      ArrayResize(opened_tickets_history, oth_size+1);
      opened_tickets_history[oth_size][0]= ticket;
      opened_tickets_history[oth_size][1]= SL_prof_ADR;
      opened_tickets_history[oth_size][2]= SL_prof_pips;
      opened_tickets_history[oth_size][3]= BE_SL_ADR;
      opened_tickets_history[oth_size][4]= BE_SL_ADR_pips;
      opened_tickets_history[oth_size][5]= 0;
      Alert("opened_tickets_history is larger than 1");
      }*/
   //if(oth_size == 1)
    //  {
    Alert(__FUNCTION__," ticket: ", ticket);
      opened_tickets_history[0][0]= ticket;
      opened_tickets_history[0][1]= SL_prof_ADR;
      opened_tickets_history[0][2]= SL_prof_pips;
      opened_tickets_history[0][3]= BE_SL_ADR;
      opened_tickets_history[0][4]= BE_SL_ADR_pips;
      opened_tickets_history[0][5]= 0;
   //   }
   //else Alert(__FUNCTION__," variable oth_size in append_opened_tickets_history is 0"); 
    display_error(__FUNCTION__);
   }
//--- Changes trade_signal to either BUY (0), SELL (1) or WAIT (2)
//--- If all indicators go UP,  trade_signal == BUY... DOWN > SELL, or WAIT if neigher.
void setActiveIndiDirections(int bar_A,int bar_B)
  {
   for(int i=0; i<activeIndicators; i++)
      ActiveIndiDirections[i]=indicator_direction(ActiveIndicators[i],bar_A,bar_B);
   display_error(__FUNCTION__);
  }
//--- sets trade_signal to BUY (0), SELL (1), or WAIT (2). If all indicator directions are
//--- UP, trade_signal is changed to BUY. if all indicator directions are DOWN, trade signal is changed
//--- to SELL. if all indicators are flat, change trade_signal to WAIT.    
void set_trade_signal()
  {
   first_direction=ActiveIndiDirections[0];
// if all indicators go UP, trade_signal = BUY, so close short position and open long
   int signal_placeholder;
   if(first_direction==UP) // if the first direction is UP (0)
     {
      signal_placeholder=BUY;
      for(int i=0; i<activeIndicators; i++)
        {
         int dirStep= ActiveIndiDirections[i];
         if(dirStep == DOWN|| dirStep == NODIR)
            signal_placeholder=WAIT;
        }
      if(signal_placeholder == BUY)
         trade_signal= BUY;
     }
// if all indicators go DOWN, trade_signal = SELL, so close long position and open short
   else if(first_direction==DOWN) // if the first directi onis DOWN (1)
     {
      signal_placeholder=SELL;
      for(int i=0; i<activeIndicators; i++)
        {
         int dirStep= ActiveIndiDirections[i];
         if(dirStep == UP|| dirStep == NODIR)
            signal_placeholder=WAIT;
        }
      if(signal_placeholder == SELL)   
         trade_signal= SELL; 
     }
// if neither: don't make any trades
   /*
   else
     {
      int signal_placeholder=WAIT;
      for(int i=0; i<activeIndicators; i++)
        {
         int dirStep= ActiveIndiDirections[i];
         if(dirStep == UP|| dirStep == DOWN)
            signal_placeholder=3;
        }
      if(signal_placeholder==WAIT)
         trade_signal=WAIT;
     }*/
   display_error(__FUNCTION__);
  }
//--- Sets the first value of trade_signal to BUY (0), SELL (1), or WAIT (2) during OnInit().
//--- Follows the same logic as set_trade_signal() except it keeps going back
//--- from bars 1>2>3... until it finds a point where all indicators go either
//--- up or down, the sets trade_signal to that value.
void init_trade_signal()
  {
   int firstBar=1;
   int secondBar=2;
   do
     {
      if(secondBar >= Bars) break;
      setActiveIndiDirections(firstBar,secondBar);
      set_trade_signal();
      firstBar++;
      secondBar++;
     }
   while(trade_signal == WAIT);
   first_trade_signal = trade_signal;

   if(startWaitOrGo==goFirst)
      trade_signal_changed=true;
   else trade_signal_changed=false; 
   display_error(__FUNCTION__);
  }
//------------------------------------------------Trade Signal Methods---------------------------------------------//

//--- Returns the direction of whatever indicator is the parameter.
//--- UP (0),  DOWN (1), or NODIR (2)
int indicator_direction(int indicator,int bar_A,int bar_B)
  {
   switch(indicator)
     {
      case 0:  return MA_direction(bar_A, bar_B);                 //const MA = 0 
      case 1:  return Stoch_Osc_direction(bar_A, bar_B);          //const STOCH_OSC = 1
      case 2:  return THV3_T3_direction(bar_A, bar_B);            //const THV3_T3 = 2
      case 3:  return Stoch_RSI_Basic_direction(bar_A, bar_B);    //const STOCH_RSI_BASIC = 3
      case 4:  return Babon_Slope_direction(bar_A, bar_B);        //const BABON_SLOPE = 4
      case 5:  return THV_T3_Trix_direction(bar_A, bar_B);        //const THV_T3_TRIX = 5
      case 6:  return AMA_optimized_direction(bar_A);             //const AMA_OPTIMIZED = 6
      default: Print("switch block failed: value was not an indicator");
     }
   display_error(__FUNCTION__);
   return(-1);
  }
//--- detects a pullback and returns true or false. 
//--- if trade_signal == BUY,  it only looks for downwards pullback
//--- if trade_singal == SELL, it only looks for upwards pullback
bool detect_pullback()
  {
  /*
   if(ObjectFind(0,"topline"))
      {
      Alert("---Object found");
      if(!ObjectDelete("topline"))
         Alert("---failed to remove object");
      }
    
   int obj_total=ObjectsTotal();
   for(int i=obj_total-1;i>=0;i--)
     {
      string name=ObjectName(i);
      if(name == "topline")
         ObjectDelete(name);
     }     
   ObjectCreate("topline",OBJ_HLINE,0,TimeCurrent(),Bid);
   ObjectSetInteger(0,"topline",OBJPROP_COLOR,Orange);
   ObjectSetInteger(0,"topline",OBJPROP_STYLE,STYLE_DASH);
   ObjectSetInteger(0,"topline" ,OBJPROP_WIDTH,1);
*/  
//--- takes the retracement time, and % retracement for a pullback and 
//--- computes the pullback amount
   if(enter_method==enter_directly)
      return(true);
   double lowest,highest,diff;
   int low_index,high_index;
// if we're using time in min and not chart bars
   if(pullback_type == use_minutes)
     {
      if(trade_signal==SELL)
        {
         low_index=iLowest(Symbol(),PERIOD_M1,MODE_LOW,pbMaxBars,0);
         lowest=iLow(Symbol(),PERIOD_M1,low_index);
         highest=Ask;
        }
      // detects downward retracement (when indicators are going up)
      else if(trade_signal==BUY)
        {
         high_index=iHighest(Symbol(),PERIOD_M1,MODE_HIGH,pbMaxBars,0);
         highest= iHigh(Symbol(),PERIOD_M1,high_index);
         lowest = Ask;
        }
      display_error(__FUNCTION__);
     }
// if we're using chart bars and not minutes
   else if(pullback_type == use_bars)
     {
      if(trade_signal==SELL)
        {
         low_index=iLowest(Symbol(),PERIOD_CURRENT,MODE_LOW,pbMaxBars,0);
         lowest=Low[low_index];
         highest=Ask;
        }
      // detects downward retracement (when indicators are going up)
      else if(trade_signal==BUY)
        {
         high_index=iHighest(Symbol(),PERIOD_CURRENT,MODE_HIGH,pbMaxBars,0);
         highest= High[high_index];
         lowest = Ask;
        }
     }
   diff=highest-lowest;
   if(diff>=min_pullback_amount())
      {
       display_error(__FUNCTION__);
       return(true); 
      }
   display_error(__FUNCTION__);
   return (false);
  }

double min_pullback_amount()
  {
   double lowest,highest,diff,pbAmount;
   int low_index,high_index;
// if we're using time in min instead of bars
   if(pullback_type == use_minutes)
     {
     if(trade_signal==SELL)
        {
         high_index=iHighest(Symbol(),PERIOD_M1,MODE_HIGH,pbRetraceBars,0);
         highest=iHigh(Symbol(),PERIOD_M1,high_index);
         low_index=iLowest(Symbol(),PERIOD_M1,MODE_LOW,high_index,0);
         highest=iHigh(Symbol(),PERIOD_M1,high_index);
        }
      // detects downward retracement (when indicators are going up)
      else if(trade_signal==BUY)
        {
         low_index=iLowest(Symbol(),PERIOD_M1,MODE_LOW,pbRetraceBars,0);
         lowest=iLow(Symbol(),PERIOD_M1,low_index);
         high_index=iHighest(Symbol(),PERIOD_M1,MODE_HIGH,low_index,0);
         highest=iHigh(Symbol(),PERIOD_M1,high_index);
        }
     /*
      low_index=iLowest(Symbol(),PERIOD_M1,MODE_LOW,pbRetraceTime,0);
      lowest=iLow(Symbol(),PERIOD_M1,low_index);
      high_index=iHighest(Symbol(),PERIOD_M1,MODE_HIGH,pbRetraceTime,0);
      highest=iHigh(Symbol(),PERIOD_M1,high_index);*/
     }
// if we're using bars and not minutess
   else if(pullback_type == use_bars)
     {
     if(trade_signal==SELL)
        {
         high_index=iHighest(Symbol(),0,MODE_HIGH,pbRetraceBars,0);
         highest=High[high_index];
         low_index=iLowest(Symbol(),0,MODE_LOW,high_index,0);
         lowest=Low[low_index];
        }
      // detects downward retracement (when indicators are going up)
      else if(trade_signal==BUY)
        {
         low_index=iLowest(Symbol(),0,MODE_LOW,pbRetraceBars,0);
         lowest=Low[low_index];
         high_index=iHighest(Symbol(),0,MODE_HIGH,low_index,0);
         highest=High[high_index];
        }
     /*
      low_index=iLowest(Symbol(),0,MODE_LOW,pbRetraceBars,0);
      lowest=Low[low_index];
      high_index=iHighest(Symbol(),0,MODE_HIGH,pbRetraceBars,0);
      highest=High[high_index];*/
     }
   int obj_total=ObjectsTotal();
   display_error("ObjectsTotal. ");
   if(obj_total > 0)
      {
      for(int i=obj_total-1; i>=0; i--)
        {
         string name=ObjectName(i);
         if(name == "bottomline")
            {
             if(!ObjectDelete(name))
               {
                Alert(__FUNCTION__," bottomline failed to delete.");
               }   
            }       
         else if(name == "topline")
            {
             if(!ObjectDelete(name))
               {
                Alert(__FUNCTION__," topline failed to delete.");
               }
            }
        }    
      } 
   //Alert("--- low_index: ", low_index, " high_index: ", high_index);
   //Alert("--- lowest: ", lowest, " highest: ", highest);
   if(trade_signal != WAIT)
      {
      ObjectCreate("bottomline",OBJ_HLINE,0,TimeCurrent(),lowest);
      ObjectSetInteger(0,"bottomline",OBJPROP_COLOR,Yellow);
      ObjectSetInteger(0,"bottomline",OBJPROP_STYLE,STYLE_DASH);
      ObjectSetInteger(0,"bottomline" ,OBJPROP_WIDTH,1);
      
      ObjectCreate("topline",OBJ_HLINE,0,TimeCurrent(),highest);
      ObjectSetInteger(0,"topline",OBJPROP_COLOR,Orange);
      ObjectSetInteger(0,"topline",OBJPROP_STYLE,STYLE_DASH);
      ObjectSetInteger(0,"topline" ,OBJPROP_WIDTH,1);
      }
/*
   int obj_total=ObjectsTotal();
         for(int i=obj_total-1;i>=0;i--)
            {
            string name=ObjectName(i);
            if(name == "topline")
               ObjectDelete(name);
            }     
         ObjectCreate("topline",OBJ_HLINE,0,TimeCurrent(),highest);
         ObjectSetInteger(0,"topline",OBJPROP_COLOR,Orange);
         ObjectSetInteger(0,"topline",OBJPROP_STYLE,STYLE_DASH);
         ObjectSetInteger(0,"topline" ,OBJPROP_WIDTH,1); */
   diff=highest-lowest;
   pbAmount=diff*pbRetracePercent/100;
   display_error(__FUNCTION__);
   return(pbAmount);
  }
//--- Calculates the ADR for the amount of days specified
double calc_ADR(int numday)
  {
   double ADR;
   double sum=0;
   int c=0;
   for(int i=1; i<Bars-1; i++)
     {
      double hi = iHigh(NULL,PERIOD_D1,i);
      double lo = iLow(NULL,PERIOD_D1,i);
      datetime dt=iTime(NULL,PERIOD_D1,i);
      if(TimeDayOfWeek(dt)>0 && TimeDayOfWeek(dt)<6)
        {
         sum+=hi-lo;
         c++;
         if(c>=numday) break;
        }
     }
   ADR=sum/c/pnt;
   display_error(__FUNCTION__);
   return(ADR);
  }

//--- Fill the Tickets[1][9] array with all open orders
void setTickets(double &Tickets[][])
  {
   int total=OrdersTotal();
   int countingOrders=0;
   if(total>1) Alert(__FUNCTION__," More than one open order. ",total," orders open");
   for(int i=0; i<total; i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) continue;    // if order can't be found, skip this iteration
      if(MAGICNUMBER != OrderMagicNumber()) continue;            // if order is from a different EA, skip
      countingOrders++;
      Tickets[i][0] = OrderTicket();
      Tickets[i][1] = OrderType();
      Tickets[i][2] = OrderLots();
      Tickets[i][3] = OrderOpenPrice();
      Tickets[i][4] = OrderStopLoss();
      Tickets[i][5] = OrderTakeProfit();
      Tickets[i][6] = OrderMagicNumber();
      Tickets[i][7] = OrderExpiration();
      Tickets[i][8] = OrderOpenTime();
     }
   ArrayResize(Tickets,countingOrders);
   display_error(__FUNCTION__);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int last_closed_order_ticket()
  {
   if(OrdersHistoryTotal() <= 0) return(0);
   for(int i=OrdersHistoryTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY))
        {
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==MAGICNUMBER) break;
        }
     }
   display_error(__FUNCTION__);
   return(OrderTicket());
  }
//--- If the last order that closed closed on stoploss and the indicators are still
//--- going in the same direction, change SL_triggered to True so no more trades will 
//--- be made until the indicators switch directions  
bool set_SL_occured()
  {
   if(use_SL_trigger == false) return(false);
   if(OrdersHistoryTotal() <= 0) return (false);
   if(OrderSelect(curClosedOrder, SELECT_BY_TICKET, MODE_HISTORY) == false) return(false);
   double orderC=NormalizeDouble(OrderClosePrice(),dig);
   double orderSL = NormalizeDouble(OrderStopLoss(), dig);
   if(OrderType() == OP_BUY)
     {
      if(orderC <= orderSL) return(true);
     }
   else if(OrderType()==OP_SELL)
     {
      if(orderC >= orderSL) return (true);
     }
   display_error(__FUNCTION__);
   return (false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool set_TP_occured()
  {
   if(use_TP_trigger == false) return(false);
   if(OrdersHistoryTotal() <= 0) return (false);
   if(OrderSelect(curClosedOrder, SELECT_BY_TICKET, MODE_HISTORY) == false) return(false);
   double orderC=NormalizeDouble(OrderClosePrice(),dig);
   double orderTP = NormalizeDouble(OrderTakeProfit(), dig);
   if(OrderType() == OP_BUY)
     {
      display_error(__FUNCTION__);
      if(orderC >= orderTP) return(true);
     }
   if(OrderType()==OP_SELL)
     {
      display_error(__FUNCTION__);
      if(orderC <= orderTP) return (true);
     }
   display_error(__FUNCTION__);
   return (false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SL_TP_check()
  {
   curClosedOrder=last_closed_order_ticket();
   if(curClosedOrder>lasClosedOrder)
     {
      SL_occured = set_SL_occured();
      TP_occured = set_TP_occured();
      if(SL_occured || TP_occured)
        {
         SL_TP_stop=true;
        }
      lasClosedOrder=curClosedOrder;
     }
   else if(curClosedOrder<lasClosedOrder)
     {
      lasClosedOrder=curClosedOrder;
     }
   if(SL_TP_stop==true && dir_has_switched_from_SL_TP()==true)
     {
      SL_TP_stop=false;
     }
   display_error(__FUNCTION__);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool dir_has_switched_from_SL_TP()
  {
   if(OrderSelect(curClosedOrder, SELECT_BY_TICKET, MODE_HISTORY) == false) return(false);
   int orderT=OrderType();
   if(SL_occured || TP_occured)
     {
      if((orderT==OP_BUY) && (trade_signal==OP_SELL))
        {
         display_error(__FUNCTION__);
         return(true);
        }
      if((orderT==OP_SELL) && (trade_signal==OP_BUY))
        {
         display_error(__FUNCTION__);
         return(true);
        }
     }
   display_error(__FUNCTION__);
   return(false);
  }
//--- determines whether to trade on the current day
bool trade_on_day()
  {
   datetime todaydt=TimeLocal();
   MqlDateTime mqldt;
   TimeToStruct(todaydt,mqldt);
   int weekday=mqldt.day_of_week;
   if(day1notrade == weekday) return(false);
   if(day2notrade == weekday) return(false);
   if(day3notrade == weekday) return(false);
   if(day4notrade == weekday) return(false);
   if(day5notrade == weekday) return(false);
   if(day6notrade == weekday) return(false);
   display_error(__FUNCTION__);
   return(true);
  }
//--- determines whether or not to trade based on the current time
bool trade_on_time()
  {
   if(trade_around_clock == true) return(true);
   datetime todaydt=TimeLocal();
   MqlDateTime mqldt;
   TimeToStruct(todaydt,mqldt);
   int hour=mqldt.hour;
   int minute=mqldt.min;
   if(hour < hour_start) return(false);
   if(hour > hour_stop && hour_stop != 0 && min_stop != 0) return (false);
   if(hour==hour_start)
     {   
      if(minute < min_start) return(false);
     }
   if(hour==hour_stop && hour_stop!=0 && min_stop!=0)
     {
      if(minute >= min_stop) return(false);
     }
   display_error(__FUNCTION__);
   return(true);
  }
//--- Returns true if trading is allowed by all other checks
bool good_to_trade()
  {
   SL_TP_check();
   below_max_spread=true;
   if(MarketInfo(Symbol(),MODE_SPREAD)/10>=max_spread_allowed)
      below_max_spread=false;
   set_trade_signal_changed();
   if(new_bar == false)   return(false);
   if(detect_pullback() == false)        return(false);
   if(SL_TP_stop == true)                return(false);
   if(below_max_spread == false)         return(false);
   if(OrdersTotal() != 0)                return(false);
   if(trade_on_day() == false)           return(false);
   if(trade_on_time() == false)          return(false);
   if(trade_signal_changed == false)     return(false);
   display_error(__FUNCTION__);
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool is_first_tick_in_bar()
  {
   curBarTime=Time[0];
   if(curBarTime>lastBarTime)
     {
      lastBarTime=curBarTime;
      display_error(__FUNCTION__); 
      return(true);
     }
   display_error(__FUNCTION__);
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void set_trade_signal_changed()
  {
   if(trade_signal_changed==true)
      return;
   if(first_trade_signal==BUY && trade_signal==SELL)
      trade_signal_changed=true;
   else if(first_trade_signal==SELL && trade_signal==BUY)
      trade_signal_changed=true;
   else trade_signal_changed=false;
   display_error(__FUNCTION__);
  }
//+------------------------------------------------------------------+
//| Functions for checking input variables                           |
//+------------------------------------------------------------------+

//--- checks external variables for conflicts/incomopletes and notifies the user
//--- returns true if everything is correct, and false if something is wrong.
bool check_all_externs()
  {
   check_MA();
   check_Stoch_Osc();
   check_THV_T3();
   check_Babon_Slope();
   check_THV3_T3_Trix();
   check_Stoch_RSI_Basic();
   check_Entering();
   check_Take_Profit();
   check_Stop_Loss();
   check_Days();
   check_Times();
   check_Lot_Size_Constant();
   check_Slippage();
   check_Max_Spread();
   check_SL_profit_lvl();
   check_timeCloseTrades();
   display_error(__FUNCTION__);
   return(externcheck);
  }
//--- Checks for inconsistencies in MA inputs. Currently doesn't do anything.   
void check_MA()
  {
  }
//--- Checks for inconsistencies in Stochastic Oscillator inputs. Currently doesn't do anything.
void check_Stoch_Osc()
  {
  }
//--- Checks for inconsistencies in THV_T3 inputs. Currently doesn't do anything.   
void check_THV_T3()
  {
  }
//--- Checks for inconsistencies in Babon Slope inputs. Currently doesn't do anything.   
void check_Babon_Slope()
  {
  }
//--- Checks for inconsistencies in THV3 T3 Trix inputs. Currently doesn't do anything. 
void check_THV3_T3_Trix()
  {
  }
//--- Check for inconsistencies in Stochastic RSI Basic inputs. Currently doesn't do anything.
void check_Stoch_RSI_Basic()
  {
  }
//--- Check for inconsistencies in Entering & pullback inputs. 
//--- Pullbacks are incomplete, so doesn't do anything.
void check_Entering()
  {
   if(enter_method == enter_directly) return;
  }
//--- Check for inconsitencies in take profit.
void check_Take_Profit()
  {
   if(TP_const_adr == constant)
     {
      if(t_prof_const==0)
        {
         Alert("Take profit constant is set to 0");
         externcheck=false;
        }
      else if(t_prof_const<0)
        {
         Alert("Take profit constant is less than 0");
         externcheck=false;
        }
     }

   else if (TP_const_adr == adr)
     {
      if(t_prof_ADR==0.0)
        {
         Alert("TP %ADR is set to 0.0%");
         externcheck=false;
        }
      else if(t_prof_ADR<0.0)
        {
         Alert("TP %ADR is less than 0.0%");
         externcheck=false;
        }
     }
   return;
  }
//--- Check for inconsistencies in stop_loss.   
void check_Stop_Loss()
  {
   if(SL_const_adr == constant)
     {
      if(s_loss_const==0)
        {
         Alert("Stop loss constant is set to 0");
         externcheck=false;
        }
      else if(s_loss_const<0)
        {
         Alert("Stop loss constant is less than 0");
         externcheck=false;
        }
     }
   else if(SL_const_adr == adr)
     {
      if(s_loss_ADR==0.0)
        {
         Alert("SL %ADR is set to 0.0%");
         externcheck=false;
        }
      else if(s_loss_ADR<0.0)
        {
         Alert("SL %ADR is less than 0.0%");
         externcheck=false;
        }
     }
   return;
  }
//---Check for inconsistencies in Days 
void check_Days()
  {
   if(day1notrade!=noday)
     {
      if(day1notrade==day2notrade || day1notrade==day3notrade || day1notrade==day4notrade
         || day1notrade==day5notrade || day1notrade==day6notrade)
        {
         Alert("Two or more days chosen not to trade on are the same days");
         externcheck=false;
         return;
        }
     }
   if(day2notrade!=noday)
     {
      if(day2notrade==day3notrade || day2notrade==day4notrade || day2notrade==day5notrade
         || day2notrade==day6notrade)
        {
         Alert("Two or more days chosen not to trade on are the same days");
         externcheck=false;
         return;
        }
     }
   if(day3notrade!=noday)
     {
      if(day3notrade==day4notrade || day3notrade==day5notrade || day3notrade==day6notrade)
        {
         Alert("Two or more days chosen not to trade on are the same days");
         externcheck=false;
         return;
        }
     }
   if(day4notrade!=noday)
     {
      if(day4notrade==day5notrade || day4notrade==day6notrade)
        {
         Alert("Two or more days chosen not to trade on are the same days");
         externcheck=false;
         return;
        }
     }
   if(day5notrade!=noday)
     {
      if(day5notrade==day6notrade)
        {
         Alert("Two or more days chosen not to trade are on the same days");
         externcheck=false;
         return;
        }
     }
  }
//--- Check for inconsistencies in Times chosen for trading within a single day.
//--- If a times are chosen that would cause trading starting one day and ending another,
//--- this will be counted as an inconsistency.
void check_Times()
  {
   if(trade_around_clock == true) return;
   if(hour_start<0)
     {
      Alert("Start hour is negative.");
      externcheck=false;
     }
   else if(hour_start>23)
     {
      Alert("Start hour is greater than 23.");
      externcheck=false;
     }
   if(min_start<0)
     {
      Alert("Start minute is negative.");
      externcheck=false;
     }
   else if(min_start>59)
     {
      Alert("Start minute is greater than 59.");
      externcheck=false;
     }
   if(hour_stop<0)
     {
      Alert("Start hour is negative.");
      externcheck=false;
     }
   else if(hour_stop>23)
     {
      Alert("Start hour is greater than 23.");
      externcheck=false;
     }
   if(min_stop<0)
     {
      Alert("Start minute is negative.");
      externcheck=false;
     }
   else if(min_stop>59)
     {
      Alert("Start minute is greater than 59.");
      externcheck=false;
     }
   if(hour_start==hour_stop && min_start==min_stop)
     {
      Alert("Trading between times is enabled and times chosen are identical");
      externcheck=false;
      return;
     }
   if(hour_stop<hour_start && (hour_stop!=0 || min_stop!=0))
     {
      Alert("Time to stop trading is earlier than time to start");
      externcheck=false;
      return;
     }
   if(hour_stop==hour_start && min_stop<min_start && (hour_stop!=0 || min_stop!=0))
     {
      Alert("Time to stop trading is earlier than time to start");
      externcheck=false;
      return;
     }
  }
//--- Checks that the lot size constant isn't 0.0.
void check_Lot_Size_Constant()
  {
   if(lot_size_const<=0.0)
     {
      Alert("Lot size constant is less than or equal to 0.0");
      externcheck=false;
      return;
     }
  }
//--- Checks that slippage isn't set to 0.
void check_Slippage()
  {
   if(slippage<=0)
     {
      Alert("Slippage is less than or equal to 0");
      externcheck=false;
      return;
     }
  }
//--- Checks that the spread isn't greater than the max spread allowed for trading
void check_Max_Spread()
  {
   if(max_spread_allowed<=0)
     {
      Alert("Max spread allowed is less than or equal to 0");
      externcheck=false;
      return;
     }
  }
void check_SL_profit_lvl()
   {
   if(SL_profit_lvl_type == constant)
      {
      if(sl_prof_lvl_const <= 0)
         {
         Alert("SL profit level constant is less than or equal to 0.");
         externcheck=false;
         }
      }
   if(SL_profit_lvl_type == adr)
      {
      if(sl_prof_lvl_pADR <= 0)  
         {
         Alert("SL profit level % ADR is less than or equal to 0.");
         externcheck=false;
         }
      }
   }
void check_timeCloseTrades()
   {
   if(dayCloseTrades != noday)
      {
      if(trade_around_clock == true)
         {
         Alert("A day to close all trades is picked when trade around the clock is enabled.");
         externcheck=false;
         }
      if(hourCloseTrades < 0)
         {
         Alert("Hour to close all trades is less than 0.");
         externcheck=false;
         }
      else if(hourCloseTrades >= 24)
         {
         Alert("Hour to close all trades is greater than or equal to 24.");
         externcheck=false;
         }
      if(minCloseTrades < 0)
         {
         Alert("Minute to close all trades is less than 0.");
         externcheck=false;
         }
      else if(minCloseTrades >= 60) 
         {
         Alert("Minute to close all trades is greater than or equal to 60.");
         externcheck=false;
         }
      if(dayCloseTrades==day1notrade) checkCloseOrderHelper();
      else if(dayCloseTrades==day2notrade) checkCloseOrderHelper();
      else if(dayCloseTrades==day3notrade) checkCloseOrderHelper();
      else if(dayCloseTrades==day4notrade) checkCloseOrderHelper();
      else if(dayCloseTrades==day5notrade) checkCloseOrderHelper();
      else if(dayCloseTrades==day6notrade) checkCloseOrderHelper();
      }
   }
void checkCloseOrderHelper()
   {
   if(hourCloseTrades < hour_stop)
      {
         Alert("Time to close all trades is before time to stop opening trades on a day where trading is allowed.");
         externcheck=false;
      }
   if(hourCloseTrades == hour_stop && minCloseTrades < min_stop)
      {
      Alert("Time to close all trades is before time to stop opening trades on a day where trading is allowed.");
      externcheck=false;
      }
   }
//+------------------------------------------------------------------+
//| Functions useful for later development                           |
//+------------------------------------------------------------------+
double OnTester()
  {
   double ret=0.0;
   return(ret);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {
  }
//+------------------------------------------------------------------+

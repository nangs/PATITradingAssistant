//+------------------------------------------------------------------+
//|                                                       Broker.mqh |
//|                                                       Dave Hanna |
//|                                http://nohypeforexrobotreview.com |
//+------------------------------------------------------------------+
#property copyright "Dave Hanna"
#property link      "http://nohypeforexrobotreview.com"
#property version   "1.00"
#property strict
#include <Position.mqh>

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Broker
  {
private:
   int startingPos;
public:
                     Broker(int symbolOffset = 0);
                    ~Broker();
                    string TypeName;
                    virtual int GetNumberOfOrders()
                    {
                     return OrdersTotal();
                    }
                    virtual Position*  GetTrade(int TicketID)
                    {
                     OrderSelect(TicketID, SELECT_BY_TICKET);
                     return (GetPosition());
                    }
                    virtual void SelectOrder(int position)
                    {
                        OrderSelect(position, SELECT_BY_POS);
                    }
                    
                    virtual Position * GetPosition()
                    {
                        Position * newTrade = new Position();
                        newTrade.TicketId = OrderTicket();
                        newTrade.OrderType = OrderType();
                        newTrade.Symbol = NormalizeSymbol(OrderSymbol());
                        newTrade.OrderOpened = OrderOpenTime();
                        newTrade.OpenPrice = OrderOpenPrice();
                        return newTrade;
                    }
 string NormalizeSymbol(string symbol)
{
   return (StringSubstr(symbol, startingPos, 6));
}

};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Broker::Broker(int symbolOffset = 0)
  {
   TypeName = "RealBroker";
   startingPos = symbolOffset;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Broker::~Broker()
  {
  }
//+------------------------------------------------------------------+




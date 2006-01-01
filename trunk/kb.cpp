#include <iostream>

using namespace std;

int main()
{
  string thisisanumber;
  string line;
  cout<<"Welcome to the EXTREMELY HYPER SUPER ALPHA of the thingy that will soon be usable ";
  ifstream myfile ( "rooms.db" );
    while (! myfile.eof() )
    {
      getline (myfile,line);
      cout << line << endl;
    }
  cout<<"Please enter a number: ";
  cin>> thisisanumber;
  cin.ignore();
  cout<<"You entered: "<< thisisanumber <<"\n";
  if (
  cin.get();
}

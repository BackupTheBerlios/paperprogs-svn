// -*- C++ -*- generated by wxGlade 0.4.1 on Sat Mar 11 11:30:15 2006

#include <wx/wx.h>
#include <wx/image.h>
// begin wxGlade: ::dependencies
// end wxGlade


#ifndef RANDD_H
#define RANDD_H

   class MainApp: public wxApp // MainApp is the class for our application
   { 
   // MainApp just acts as a container for the window,
   public: // or frame in MainFrame
     virtual bool OnInit();
   };
   
class MyFrame: public wxFrame {
public:
    // begin wxGlade: MyFrame::ids
    // end wxGlade

    MyFrame(wxWindow* parent, int id, const wxString& title, const wxPoint& pos=wxDefaultPosition, const wxSize& size=wxDefaultSize, long style=wxDEFAULT_FRAME_STYLE);

private:
    // begin wxGlade: MyFrame::methods
    void set_properties();
    void do_layout();
    // end wxGlade

protected:
    // begin wxGlade: MyFrame::attributes
    wxStatusBar* Stats;
    wxStaticText* label_8;
    wxStaticText* label_6;
    wxTextCtrl* text_ctrl_3;
    wxStaticText* label_7;
    wxStaticText* label_5_copy;
    wxTextCtrl* text_ctrl_4;
    wxButton* button_1;
    // end wxGlade

    DECLARE_EVENT_TABLE();

public:
    void genrand(wxCommandEvent &event); // wxGlade: <event_handler>
}; // wxGlade: end class


#endif // RANDD_H

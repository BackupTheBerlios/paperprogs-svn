// -*- C++ -*- generated by wxGlade 0.4.1 on Sat Mar 11 11:46:00 2006

#include <wx/wx.h>
#include <wx/splash.h>
#include <wx/image.h>
#include <zlib.h>
// begin wxGlade: ::dependencies
// end wxGlade


#ifndef CRAPPPP_H
#define CRAPPPP_H


class MyFrame: public wxDialog {
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
    wxButton* button_2;
    wxButton* button_3;
    // end wxGlade

    DECLARE_EVENT_TABLE();

public:
    void genrand(wxCommandEvent &event); // wxGlade: <event_handler>
    void OnAbot(wxCommandEvent &event);
    void OnExit(wxCommandEvent &event);
}; // wxGlade: end class


#endif // CRAPPPP_H

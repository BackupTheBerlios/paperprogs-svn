VERSION 5.00
Begin VB.Form project 
   Caption         =   "Random Number Generator"
   ClientHeight    =   5940
   ClientLeft      =   7110
   ClientTop       =   2775
   ClientWidth     =   7350
   LinkTopic       =   "Form1"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5940
   ScaleWidth      =   7350
   Begin VB.TextBox Guess_2 
      Height          =   735
      Left            =   4920
      TabIndex        =   5
      Text            =   "Player 2 Guess"
      Top             =   1200
      Width           =   2415
   End
   Begin VB.CommandButton rnd_submit 
      Caption         =   "Randomize!"
      Height          =   735
      Left            =   2520
      TabIndex        =   2
      Top             =   1200
      Width           =   2295
   End
   Begin VB.TextBox Guess_1 
      Height          =   735
      Left            =   0
      TabIndex        =   1
      Text            =   "Player 1 guess"
      Top             =   1200
      Width           =   2415
   End
   Begin VB.Label Label3 
      Caption         =   "Paperprogs Random Number Generator 3.1B                           Multiplayer Windows Edition!"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   0
      TabIndex        =   4
      Top             =   120
      Width           =   7935
   End
   Begin VB.Label Label2 
      Caption         =   "The number is :"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2760
      TabIndex        =   3
      Top             =   1920
      Width           =   1815
   End
   Begin VB.Label Label1 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   72
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3495
      Left            =   0
      TabIndex        =   0
      Top             =   2400
      Width           =   7335
   End
End
Attribute VB_Name = "project"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()


End Sub

Private Sub Text1_Change()

End Sub


Private Sub rnd_submit_Click()
Randomize Timer
x% = Int(Rnd * 10) + 1
Label1.Caption = x%
If Guess_1.Text = x% Then Label1.Caption = "Player 1 Wins."
If Guess_2.Text = x% Then Label1.Caption = "player 2 wins."
End Sub

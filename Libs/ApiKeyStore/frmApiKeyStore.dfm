object frmApiKeyStores: TfrmApiKeyStores
  Left = 0
  Top = 0
  Margins.Left = 8
  Margins.Top = 8
  Margins.Right = 8
  Margins.Bottom = 8
  BorderStyle = bsDialog
  Caption = 'API Keys'
  ClientHeight = 1112
  ClientWidth = 1683
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -30
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 240
  TextHeight = 41
  object StringGrid: TStringGrid
    Left = 13
    Top = 100
    Width = 1615
    Height = 861
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ColCount = 2
    DefaultColWidth = 160
    DefaultRowHeight = 60
    RowCount = 9
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goFixedRowDefAlign]
    TabOrder = 0
    OnDrawCell = StringGridDrawCell
    OnSelectCell = StringGridSelectCell
    OnSetEditText = StringGridSetEditText
  end
  object btnClose: TButton
    Left = 1440
    Top = 980
    Width = 188
    Height = 63
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Close'
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object btnCancel: TButton
    Left = 1200
    Top = 980
    Width = 188
    Height = 63
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
end

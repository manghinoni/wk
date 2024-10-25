object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Pedido'
  ClientHeight = 370
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 2
    Width = 44
    Height = 15
    Caption = 'N'#250'mero'
  end
  object Label2: TLabel
    Left = 8
    Top = 44
    Width = 37
    Height = 15
    Caption = 'Cliente'
  end
  object Label3: TLabel
    Left = 51
    Top = 44
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object Label4: TLabel
    Left = 8
    Top = 84
    Width = 37
    Height = 15
    Caption = 'Cidade'
  end
  object Label5: TLabel
    Left = 189
    Top = 84
    Width = 14
    Height = 15
    Caption = 'UF'
  end
  object Label12: TLabel
    Left = 380
    Top = 334
    Width = 85
    Height = 15
    Caption = 'Total do Pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtNumero: TEdit
    Left = 8
    Top = 19
    Width = 44
    Height = 23
    Alignment = taRightJustify
    TabOrder = 0
    OnExit = edtNumeroExit
  end
  object edtCodCliente: TEdit
    Left = 8
    Top = 59
    Width = 37
    Height = 23
    Alignment = taRightJustify
    TabOrder = 1
    OnExit = edtCodClienteExit
  end
  object edtNome: TEdit
    Left = 51
    Top = 59
    Width = 220
    Height = 23
    Enabled = False
    TabOrder = 2
  end
  object edtCidade: TEdit
    Left = 8
    Top = 99
    Width = 175
    Height = 23
    Enabled = False
    TabOrder = 3
  end
  object edtUF: TEdit
    Left = 189
    Top = 99
    Width = 31
    Height = 23
    Enabled = False
    TabOrder = 4
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 136
    Width = 543
    Height = 192
    Caption = 'Produtos'
    TabOrder = 5
    object Label6: TLabel
      Left = 36
      Top = 17
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object Label7: TLabel
      Left = 79
      Top = 17
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object Label8: TLabel
      Left = 3
      Top = 17
      Width = 11
      Height = 15
      Caption = 'ID'
    end
    object Label9: TLabel
      Left = 315
      Top = 16
      Width = 23
      Height = 15
      Caption = 'Qtd.'
    end
    object Label10: TLabel
      Left = 367
      Top = 16
      Width = 30
      Height = 15
      Caption = 'Pre'#231'o'
    end
    object Label11: TLabel
      Left = 445
      Top = 16
      Width = 25
      Height = 15
      Caption = 'Total'
    end
    object edtCodProduto: TEdit
      Left = 33
      Top = 32
      Width = 42
      Height = 23
      Alignment = taRightJustify
      TabOrder = 1
      OnExit = edtCodProdutoExit
    end
    object edtDescricao: TEdit
      Left = 79
      Top = 32
      Width = 220
      Height = 23
      Enabled = False
      TabOrder = 2
    end
    object edtId: TEdit
      Left = 3
      Top = 32
      Width = 27
      Height = 23
      TabOrder = 0
      OnExit = edtIdExit
    end
    object BitBtn1: TBitBtn
      Left = 491
      Top = 12
      Width = 25
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 6
    end
    object BitBtn2: TBitBtn
      Left = 505
      Top = 32
      Width = 25
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 7
    end
    object edtQuantidade: TEdit
      Left = 303
      Top = 32
      Width = 31
      Height = 23
      Alignment = taRightJustify
      TabOrder = 3
      OnKeyPress = edtQuantidadeKeyPress
    end
    object DBGrid1: TDBGrid
      Left = 3
      Top = 61
      Width = 537
      Height = 120
      DataSource = DataSource1
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 8
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnKeyPress = DBGrid1KeyPress
    end
    object edtValorUnitario: TEdit
      Left = 335
      Top = 32
      Width = 73
      Height = 23
      Alignment = taRightJustify
      TabOrder = 4
      OnKeyPress = edtValorUnitarioKeyPress
    end
    object edtValorTotal: TEdit
      Left = 412
      Top = 32
      Width = 73
      Height = 23
      Alignment = taRightJustify
      TabOrder = 5
      OnKeyPress = edtValorTotalKeyPress
    end
  end
  object edtTotalPedido: TEdit
    Left = 468
    Top = 332
    Width = 81
    Height = 23
    Alignment = taRightJustify
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object btnNovo: TButton
    Left = 58
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 7
    OnClick = btnNovoClick
  end
  object btnGravar: TButton
    Left = 8
    Top = 337
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 8
    OnClick = btnGravarClick
  end
  object fdConexao: TFDConnection
    Params.Strings = (
      'Password=1234'
      'DriverID=MySQL'
      'Database=WK'
      'User_Name=root'
      'Server=localhost')
    Left = 430
    Top = 31
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 438
    Top = 95
  end
  object mtProdutoPedido: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 304
    Top = 80
    object mtProdutoPedidoid: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 3
      FieldName = 'id'
    end
    object mtProdutoPedidonumeropedido: TIntegerField
      DisplayLabel = 'Pedido'
      DisplayWidth = 7
      FieldName = 'numeropedido'
      Visible = False
    end
    object mtProdutoPedidocodproduto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'codproduto'
    end
    object mtProdutoPedidodescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 37
      FieldName = 'descricao'
      Size = 50
    end
    object mtProdutoPedidoquantidade: TCurrencyField
      DisplayLabel = 'Qtd.'
      DisplayWidth = 4
      FieldName = 'quantidade'
      DisplayFormat = '0000'
    end
    object mtProdutoPedidovalorunitario: TCurrencyField
      DisplayLabel = 'Pre'#231'o'
      DisplayWidth = 9
      FieldName = 'valorunitario'
      DisplayFormat = '#,###,##0.00'
    end
    object mtProdutoPedidovalortotal: TCurrencyField
      DisplayLabel = 'Total'
      DisplayWidth = 13
      FieldName = 'valortotal'
      DisplayFormat = '#,###,##0.00'
    end
  end
  object DataSource1: TDataSource
    DataSet = mtProdutoPedido
    Left = 360
    Top = 80
  end
end

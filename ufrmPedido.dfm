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
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
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
  object Label13: TLabel
    Left = 236
    Top = 85
    Width = 43
    Height = 15
    Caption = 'Emiss'#227'o'
  end
  object edtNumero: TEdit
    Left = 8
    Top = 15
    Width = 44
    Height = 23
    TabStop = False
    Alignment = taRightJustify
    Enabled = False
    NumbersOnly = True
    ReadOnly = True
    TabOrder = 0
    OnExit = edtNumeroExit
  end
  object edtCodCliente: TEdit
    Left = 8
    Top = 59
    Width = 44
    Height = 23
    Alignment = taRightJustify
    NumbersOnly = True
    TabOrder = 1
    OnChange = edtCodClienteChange
    OnExit = edtCodClienteExit
  end
  object edtNome: TEdit
    Left = 58
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
  object gbProduto: TGroupBox
    Left = 8
    Top = 136
    Width = 543
    Height = 192
    Caption = 'Produtos'
    TabOrder = 5
    object Label6: TLabel
      Left = 6
      Top = 17
      Width = 39
      Height = 15
      Caption = 'C'#243'digo'
    end
    object Label7: TLabel
      Left = 49
      Top = 17
      Width = 51
      Height = 15
      Caption = 'Descri'#231#227'o'
    end
    object Label8: TLabel
      Left = 168
      Top = 3
      Width = 11
      Height = 15
      Caption = 'ID'
    end
    object Label9: TLabel
      Left = 279
      Top = 16
      Width = 23
      Height = 15
      Caption = 'Qtd.'
    end
    object Label10: TLabel
      Left = 337
      Top = 16
      Width = 30
      Height = 15
      Caption = 'Pre'#231'o'
    end
    object Label11: TLabel
      Left = 415
      Top = 16
      Width = 25
      Height = 15
      Caption = 'Total'
    end
    object edtCodProduto: TEdit
      Left = 3
      Top = 32
      Width = 42
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 1
      OnChange = edtCodProdutoChange
      OnExit = edtCodProdutoExit
    end
    object edtDescricao: TEdit
      Left = 49
      Top = 32
      Width = 220
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtId: TEdit
      Left = 185
      Top = -8
      Width = 27
      Height = 23
      TabOrder = 0
      Visible = False
      OnExit = edtIdExit
    end
    object btbOk: TBitBtn
      Left = 461
      Top = 30
      Width = 25
      Height = 25
      Enabled = False
      Kind = bkAll
      NumGlyphs = 2
      TabOrder = 6
      OnClick = btbOkClick
    end
    object edtQuantidade: TEdit
      Left = 275
      Top = 32
      Width = 31
      Height = 23
      Alignment = taRightJustify
      NumbersOnly = True
      TabOrder = 3
      OnExit = edtQuantidadeExit
    end
    object DBGrid1: TDBGrid
      Left = 3
      Top = 61
      Width = 537
      Height = 120
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 7
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnEnter = DBGrid1Enter
      OnExit = DBGrid1Exit
      OnKeyDown = DBGrid1KeyDown
      OnKeyPress = DBGrid1KeyPress
    end
    object edtValorUnitario: TEdit
      Left = 305
      Top = 32
      Width = 73
      Height = 23
      Alignment = taRightJustify
      TabOrder = 4
      OnExit = edtQuantidadeExit
      OnKeyPress = edtValorUnitarioKeyPress
    end
    object edtValorTotal: TEdit
      Left = 382
      Top = 32
      Width = 73
      Height = 23
      TabStop = False
      Alignment = taRightJustify
      ReadOnly = True
      TabOrder = 5
      OnKeyPress = edtValorTotalKeyPress
    end
    object btbIncluir: TBitBtn
      Left = 492
      Top = 30
      Width = 25
      Height = 25
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ModalResult = 4
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 8
      OnClick = btbIncluirClick
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
    TabStop = False
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
  object btnLimpar: TButton
    Left = 89
    Top = 337
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 9
    OnClick = btnLimparClick
  end
  object btnCancelar: TButton
    Left = 216
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 10
    TabStop = False
    OnClick = btnCancelarClick
  end
  object btnCarregar: TButton
    Left = 135
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Carregar'
    TabOrder = 11
    TabStop = False
    OnClick = btnCarregarClick
  end
  object dtEmissao: TDateTimePicker
    Left = 232
    Top = 99
    Width = 97
    Height = 23
    Date = 45592.000000000000000000
    Time = 0.657085972219647400
    Enabled = False
    TabOrder = 12
  end
  object fdConexao: TFDConnection
    Params.Strings = (
      'Password=1234'
      'DriverID=MySQL'
      'Database=WK'
      'User_Name=root'
      'Server=localhost')
    Transaction = fdTransacao
    Left = 438
    Top = 15
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 430
    Top = 71
  end
  object mtProdutoPedido: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'numeropedido'
        DataType = ftInteger
      end
      item
        Name = 'codproduto'
        DataType = ftInteger
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'valorunitario'
        DataType = ftCurrency
        Precision = 19
      end
      item
        Name = 'valortotal'
        DataType = ftCurrency
        Precision = 19
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 504
    Top = 8
    object mtProdutoPedidoid: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 3
      FieldName = 'id'
      Visible = False
    end
    object mtProdutoPedidonumeropedido: TIntegerField
      DisplayLabel = 'Pedido'
      DisplayWidth = 7
      FieldName = 'numeropedido'
      Visible = False
    end
    object mtProdutoPedidocodproduto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 7
      FieldName = 'codproduto'
    end
    object mtProdutoPedidodescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 32
      FieldName = 'descricao'
      Size = 50
    end
    object mtProdutoPedidoquantidade: TIntegerField
      DisplayLabel = 'Qtd.'
      FieldName = 'quantidade'
    end
    object mtProdutoPedidovalorunitario: TCurrencyField
      DisplayLabel = 'Pre'#231'o'
      DisplayWidth = 12
      FieldName = 'valorunitario'
      DisplayFormat = '#,###,##0.00'
    end
    object mtProdutoPedidovalortotal: TCurrencyField
      DisplayLabel = 'Total'
      DisplayWidth = 15
      FieldName = 'valortotal'
      DisplayFormat = '#,###,##0.00'
    end
  end
  object DataSource1: TDataSource
    DataSet = mtProdutoPedido
    Left = 496
    Top = 64
  end
  object fdTransacao: TFDTransaction
    Connection = fdConexao
    Left = 384
    Top = 16
  end
end

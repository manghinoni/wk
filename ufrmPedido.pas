unit ufrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  uPedido, Vcl.DBGrids, Vcl.Mask, System.UITypes;

type
  TAcao = (Nada, Consulta, Alteracao, Inclusao);

  TfrmPedido = class(TForm)
    fdConexao: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    edtNumero: TEdit;
    Label1: TLabel;
    edtCodCliente: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    edtCidade: TEdit;
    Label4: TLabel;
    edtUF: TEdit;
    Label5: TLabel;
    gbProduto: TGroupBox;
    edtCodProduto: TEdit;
    Label6: TLabel;
    edtDescricao: TEdit;
    Label7: TLabel;
    edtId: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    btbOk: TBitBtn;
    Label12: TLabel;
    edtQuantidade: TEdit;
    edtTotalPedido: TEdit;
    btnNovo: TButton;
    mtProdutoPedido: TFDMemTable;
    mtProdutoPedidoid: TIntegerField;
    mtProdutoPedidonumeropedido: TIntegerField;
    mtProdutoPedidocodproduto: TIntegerField;
    mtProdutoPedidodescricao: TStringField;
    mtProdutoPedidovalorunitario: TCurrencyField;
    mtProdutoPedidovalortotal: TCurrencyField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    edtValorUnitario: TEdit;
    edtValorTotal: TEdit;
    btnGravar: TButton;
    btnLimpar: TButton;
    btbIncluir: TBitBtn;
    mtProdutoPedidoquantidade: TIntegerField;
    fdTransacao: TFDTransaction;
    btnCancelar: TButton;
    btnCarregar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtNumeroExit(Sender: TObject);
    procedure LimparCliente;
    procedure LimparProduto;
    procedure btnNovoClick(Sender: TObject);
    procedure edtIdExit(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTotalKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btbIncluirClick(Sender: TObject);
    procedure btbOkClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodClienteChange(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
  private
    { Private declarations }
    APedido: TPedido;
    Acao: TAcao;
    function ConectarBanco: boolean;
    procedure SetAcao(AAcao: TAcao);
    procedure TotalPedido;

  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;

implementation

uses uCliente, uProduto, uProdutoPedido;

{$R *.dfm}

{ TfrmPedido }

function  Ret_Numero(Key: Char; Texto: string; Decimal: Boolean = False): Char;
begin
  if not Decimal then
  begin
    if not (CharInSet(Key, ['0'..'9', Chr(8)])) then
      Key := #0;
  end
  else
    begin
      if  Key = #46 then
        Key := FormatSettings.DecimalSeparator;
      if  not ( CharInSet(Key,['0'..'9', Chr(8), FormatSettings.DecimalSeparator])) then
        Key := #0
      else
        if  (Key = FormatSettings.DecimalSeparator) and ( Pos( Key, Texto ) > 0 ) then
          Key := #0;
    end;
  Result := Key;
end;

procedure TfrmPedido.btbIncluirClick(Sender: TObject);
begin
  edtId.Text := '0';
  edtCodProduto.SetFocus;
  LimparProduto;
end;

procedure TfrmPedido.btbOkClick(Sender: TObject);
begin
  if (edtQuantidade.Text = '') or (edtValorUnitario.Text = '0') or (edtValorTotal.Text = '') then
  begin
    ShowMessage('Todos os campos devem ser informados');
    exit;
  end;
  if (edtId.Text <> '0') and (edtId.Text <> '') then
  begin
    mtProdutoPedido.Locate('id', StrToInt(edtId.Text), []);
    mtProdutoPedido.Edit;
  end
  else
  begin
    mtProdutoPedido.Insert;
    mtProdutoPedidoid.Value := (mtProdutoPedido.RecordCount + 1) * (-1);
  end;
  mtProdutoPedidocodproduto.AsInteger := StrToInt(edtCodProduto.Text);
  mtProdutoPedidodescricao.AsString := edtDescricao.Text;
  mtProdutoPedidoquantidade.AsCurrency := StrToCurr(edtQuantidade.Text);
  mtProdutoPedidovalorunitario.AsCurrency := StrToCurr(edtValorUnitario.Text);
  mtProdutoPedidovalortotal.AsCurrency := StrToCurr(edtValorTotal.Text);
  mtProdutoPedido.Post;
  edtId.Text := '';
  edtCodProduto.Text := '';
  LimparProduto;
  TotalPedido;
  if Acao = Consulta then
    SetAcao(Alteracao);
end;

procedure TfrmPedido.btnGravarClick(Sender: TObject);
var
  AProdutoPedido: TProdutoPedido;
begin
  if (edtCodCliente.Text = '') or (mtProdutoPedido.RecordCount = 0) then
  begin
    ShowMessage('Cliente e produtos devem ser informados');
    exit;
  end;
  AProdutoPedido := TProdutoPedido.Create(fdConexao);
  try
    fdTransacao.StartTransaction;
    APedido.Numero := StrToInt(edtNumero.Text);
    APedido.Emissao := Now;
    APedido.CodCliente := StrToInt(edtCodCliente.Text);
    APedido.Total := StrToCurr(edtTotalPedido.Text);
    APedido.RecordObject;
    AProdutoPedido.DeleteAllByPedido(APedido.Numero);
    mtProdutoPedido.First;
    while not mtProdutoPedido.Eof do
    begin
      AProdutoPedido.SetObject(0);
      AProdutoPedido.NumeroPedido := APedido.Numero;
      AProdutoPedido.CodProduto := mtProdutoPedidocodproduto.AsInteger;
      AProdutoPedido.Quantidade := mtProdutoPedidoquantidade.AsInteger;
      AProdutoPedido.ValorUnitario := mtProdutoPedidovalorunitario.AsCurrency;
      AProdutoPedido.ValorTotal := mtProdutoPedidovalortotal.AsCurrency;
      AProdutoPedido.RecordObject;
      mtProdutoPedido.Next;
    end;

    fdTransacao.Commit;
    ShowMessage('Pedido ' + APedido.Numero.ToString + ' gravado com sucesso');
    btnLimparClick(self);
  except
    fdTransacao.Rollback;
  end;



end;

procedure TfrmPedido.btnLimparClick(Sender: TObject);
begin
  edtNumero.Text := '';
  edtCodCliente.Text := '';
  LimparCliente;
  edtCodProduto.Text := '';
  LimparProduto;
  edtTotalPedido.Text := '';
  mtProdutoPedido.EmptyDataSet;
  SetAcao(Nada);
end;

procedure TfrmPedido.btnNovoClick(Sender: TObject);
begin
  SetAcao(Inclusao);
  edtCodCliente.SetFocus;
  edtNumero.Text := '0';
  edtNumero.Enabled := false;
  LimparCliente;
  LimparProduto;
  mtProdutoPedido.EmptyDataSet;
  APedido := TPedido.Create(fdConexao);

end;

procedure TfrmPedido.btnCancelarClick(Sender: TObject);
var
  sNumero: string;
  iNumero: integer;
begin
  if InputQuery('Cancelamento de Pedido','Número Pedido:',sNumero) then
  begin
    try
      iNumero := StrToInt(sNumero);
      if APedido.SetObject(iNumero) then
      begin
        if MessageDlg('Deseja cancelar o Pedido?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 1)  = mrYes then
        begin
          if APedido.DeleteObject then
            ShowMessage('Pedido cancelado')
          else
            ShowMessage('Erro ao cancelar Pedido');
        end;
      end
      else
        ShowMessage('Pedido não encontrado');

    except
      ShowMessage('Deve ser número');
    end;
  end;
end;

procedure TfrmPedido.btnCarregarClick(Sender: TObject);
var
  sNumero: string;
  iNumero: integer;
begin
  if InputQuery('Carregar Pedido','Número Pedido:',sNumero) then
  begin
    try
      iNumero := StrToInt(sNumero);
      if APedido.SetObject(iNumero) then
      begin
        edtNumero.Text := sNumero;
        edtNumeroExit(self);
      end
      else
        ShowMessage('Pedido não encontrado');

    except
      ShowMessage('Deve ser número');
    end;
  end;
end;

function TfrmPedido.ConectarBanco: boolean;
var
  ArqIni: TIniFile;
  sArquivo: string;
  Database, UserName, Server, Port, Password, Path, DLL: string;
begin
  Result := false;
  sArquivo := ExtractFilePath(Application.ExeName) + 'config.ini';
  if FileExists(sArquivo) then
  begin
    ArqIni := TIniFile.Create(sArquivo);
    try
      Database := ArqIni.ReadString('Conexao','Database', 'WK');
      UserName := ArqIni.ReadString('Conexao','UserName', 'root');
      Server := ArqIni.ReadString('Conexao','Server', 'localhost');
      Port := ArqIni.ReadString('Conexao','Port', '3306');
      Password := ArqIni.ReadString('Conexao','Password', '1234');
      Path := ArqIni.ReadString('Conexao','Path', 'Path=D:\Projetos\WK\Win64\Debug\');
      DLL :=  ArqIni.ReadString('Conexao','Dll', 'libMySQL.dll');
    finally
      ArqIni.Free;
    end;

   fdConexao.Params.Clear;
   fdConexao.Params.Add('DriverID=MySQL');
   fdConexao.Params.Add('Server=' + Server);
   fdConexao.Params.Add('Port=' + Port);
   fdConexao.Params.Add('Database=' + Database);
   fdConexao.Params.Add('User_Name=' + UserName);
   fdConexao.Params.Add('Password=' + Password);
   FDPhysMySQLDriverLink1.VendorLib := Path + dll;

   try
     fdConexao.Open;
     Result := true;
   except
     on e: Exception do
     begin
       ShowMessage('Erro: ' + e.Message);
       Result := false;
     end;

   end;

  end;
end;

procedure TfrmPedido.DBGrid1DblClick(Sender: TObject);
begin
  if mtProdutoPedidocodproduto.Value > 0 then
  begin
    edtId.Text := mtProdutoPedidoId.AsString;
    edtCodProduto.Text := mtProdutoPedidocodproduto.AsString;
    edtDescricao.Text := mtProdutoPedidodescricao.AsString;
    edtQuantidade.Text := mtProdutoPedidoquantidade.AsString;
    edtValorUnitario.Text := mtProdutoPedidovalorunitario.AsString;
    edtValorTotal.Text := mtProdutoPedidovalortotal.AsString;

  end;
end;

procedure TfrmPedido.DBGrid1Enter(Sender: TObject);
begin
  frmPedido.KeyPreview := false;
end;

procedure TfrmPedido.DBGrid1Exit(Sender: TObject);
begin
  frmPedido.KeyPreview := true;
end;

procedure TfrmPedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE  then
  begin
    if MessageDlg('Deseja excluir o produto?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 1)  = mrYes then
     begin
       mtProdutoPedido.Delete;
       TotalPedido;
     end;
  end;
end;

procedure TfrmPedido.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    DBGrid1DblClick(self);
end;

procedure TfrmPedido.edtCodClienteChange(Sender: TObject);
begin
  btnNovo.Visible := Trim(edtCodCliente.Text) = '';
  btnCarregar.Visible := Trim(edtCodCliente.Text) = '';
  btnCancelar.Visible := Trim(edtCodCliente.Text) = '';
end;

procedure TfrmPedido.edtCodClienteExit(Sender: TObject);
var
  ACliente: TCliente;
begin
  if Trim(edtCodCliente.Text) <> '' then
  begin
    ACliente := TCliente.Create(fdConexao);
    try
      if ACliente.SetObject(StrToInt(Trim(edtCodCliente.Text))) then
      begin
        edtNome.Text := ACliente.Nome;
        edtCidade.Text := ACliente.Cidade;
        edtUF.Text := ACliente.UF;
      end
      else
      begin
        edtCodCliente.Text := '';
        edtNome.Text := '';
        edtCidade.Text := '';
        edtUF.Text := '';
        ShowMessage('Cliente não encontrado');
        edtCodCliente.SetFocus;
      end;
    finally
      ACliente.Free;
    end;
  end;
end;

procedure TfrmPedido.edtCodProdutoChange(Sender: TObject);
begin
  btbOk.enabled :=  edtCodProduto.Text <> '';
end;

procedure TfrmPedido.edtCodProdutoExit(Sender: TObject);
var
  AProduto: TProduto;
begin
  if Trim(edtCodProduto.Text) <> '' then
  begin
    AProduto := TProduto.Create(fdConexao);
    try
      if AProduto.SetObject(StrToInt(Trim(edtCodProduto.Text))) then
      begin
        edtDescricao.Text := AProduto.Descricao;
        edtValorUnitario.Text := FormatFloat('#,###,##0.00', AProduto.Preco);
      end
      else
      begin
        edtDescricao.Text := '';
        edtValorUnitario.Text := '';
        ShowMessage('Produto não encontrado');
        edtCodProduto.SetFocus;
      end;
    finally
      AProduto.Free;
    end;
  end;
end;

procedure TfrmPedido.edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  Key := Ret_Numero(Key, edtQuantidade.Text);
end;

procedure TfrmPedido.edtIdExit(Sender: TObject);
var
  AProdutoPedido: TProdutoPedido;
begin
  if Trim(edtId.Text) <> '' then
  begin
    if mtProdutoPedido.Locate('id', edtId.Text, []) then
    begin
      edtCodProduto.Text := mtProdutoPedidocodproduto.ASString;
      edtDescricao.Text := mtProdutoPedidodescricao.AsString;
      edtQuantidade.Text := mtProdutoPedidoquantidade.AsString;
      edtValorUnitario.Text := FormatFloat('#,###,##0.00', mtProdutoPedidovalorunitario.AsCurrency);
      edtValorTotal.Text := FormatFloat('#,###,##0.00', mtProdutoPedidovalortotal.AsCurrency);
    end
    else
    begin
      AProdutoPedido := TProdutoPedido.Create(fdConexao);
      try
        if AProdutoPedido.SetObject(StrToInt(Trim(edtId.Text))) then
        begin
          edtCodProduto.Text := IntToStr(AProdutoPedido.CodProduto);
          edtCodProdutoExit(self);
        end
        else
        begin
          edtCodCliente.Text := '';
          LimparCliente;
          ShowMessage('Pedido não encontrado');
          edtNumero.SetFocus;
        end;
      finally
        AProdutoPedido.Free;
      end;
    end;
  end;
end;

procedure TfrmPedido.edtNumeroExit(Sender: TObject);
var
  AProdutoPedido: TProdutoPedido;
  AQuery: TFDQuery;
begin
  if Trim(edtNumero.Text) <> '' then
  begin
    APedido := TPedido.Create(fdConexao);
    AProdutoPedido := TProdutoPedido.Create(fdConexao);
    try
      if Apedido.SetObject(StrToInt(Trim(edtNumero.Text))) then
      begin
        edtCodCliente.Text := IntToStr(APedido.CodCliente);
        edtCodClienteExit(self);
        edtTotalPedido.Text := FormatCurr('#,###,##0.00', APedido.Total);
        mtProdutoPedido.EmptyDataSet;

        try
          AQuery := TFDQuery.Create(self);
          AProdutoPedido.ListAllByPedido(APedido.Numero, AQuery);
          while not AQuery.Eof do
          begin
            mtProdutoPedido.Insert;
            mtProdutoPedidoid.Value := AQuery.FieldByName('id').AsInteger;
            mtProdutoPedidonumeropedido.Value := AQuery.FieldByName('numeropedido').AsInteger;
            mtProdutoPedidocodproduto.Value := AQuery.FieldByName('codproduto').AsInteger;
            mtProdutoPedidodescricao.AsString := AQuery.FieldByName('descricao').AsString;
            mtProdutoPedidoquantidade.Value := AQuery.FieldByName('quantidade').AsInteger;
            mtProdutoPedidovalorunitario.Value := AQuery.FieldByName('valorunitario').AsCurrency;
            mtProdutoPedidovalortotal.Value := AQuery.FieldByName('valortotal').AsCurrency;
            mtProdutoPedido.Post;
            AQuery.Next;
          end;
        finally
          AQuery.Free;
        end;
        SetAcao(Consulta);
      end
      else
      begin
        edtCodCliente.Text := '';
        LimparCliente;
        mtProdutoPedido.EmptyDataSet;
        ShowMessage('Pedido não encontrado');
        edtNumero.Text := '';
        edtNumero.SetFocus;
        SetAcao(Nada);
      end;
    finally
      AProdutoPedido.Free;
    end;
  end;
end;

procedure TfrmPedido.edtQuantidadeExit(Sender: TObject);
begin
  if Trim(edtQuantidade.Text) = '' then
    edtQuantidade.Text := '0';
  if Trim(edtValorUnitario.Text) = '' then
    edtValorUnitario.Text := '0,00';
  edtValorTotal.Text := FormatCurr('#,###,##0.00', StrToInt(edtQuantidade.Text) * StrToCurr(edtValorUnitario.Text));
end;

procedure TfrmPedido.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  Key := Ret_Numero(Key, edtQuantidade.Text);
end;

procedure TfrmPedido.edtValorTotalKeyPress(Sender: TObject; var Key: Char);
begin
  Key := Ret_Numero(Key, edtQuantidade.Text, true);
end;

procedure TfrmPedido.edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  Key := Ret_Numero(Key, edtQuantidade.Text, true);
end;

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
  if not ConectarBanco then
  begin
    ShowMessage('Não foi possível conerctar ao banco de dados, verifique');
    Close;
  end;
  APedido := TPedido.Create(fdConexao);
  SetAcao(Nada);
end;

procedure TfrmPedido.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Sender is TDBGrid) then
    if Key = #13 then begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TfrmPedido.LimparCliente;
begin
  edtNome.Text := '';
  edtCidade.Text := '';
  edtUF.Text := '';
end;

procedure TfrmPedido.LimparProduto;
begin
  edtDescricao.Text := '';
  edtQuantidade.Text := '';
  edtValorUnitario.Text := '';
  edtValorTotal.Text := '';
end;


procedure TfrmPedido.SetAcao(AAcao: TAcao);
begin
  Acao := AAcao;
  edtCodCliente.Enabled := AAcao in [Inclusao, Consulta, Alteracao] ;
  gbProduto.Enabled := AAcao in [Inclusao, Consulta, Alteracao] ;
  btnGravar.Enabled := AAcao in [Inclusao, Alteracao] ;
  btnNovo.Enabled := AAcao in [Nada, Consulta] ;
  edtNumero.Enabled := AAcao in [Nada, Consulta];
end;

procedure TfrmPedido.TotalPedido;
var
  cTotal: currency;
  bmRegistro: TBookmark;
begin
  cTotal := 0;
  if mtProdutoPedido.Active then
  begin
    bmRegistro := mtProdutoPedido.GetBookmark;
    mtProdutoPedido.First;

    while not mtProdutoPedido.Eof do
    begin
      cTotal := cTotal + mtProdutoPedidovalortotal.Value;
      mtProdutoPedido.Next;
    end;
  end;
  edtTotalPedido.Text := FormatCurr('#,###,##0.00', cTotal);
  mtProdutoPedido.GotoBookmark(bmRegistro);
end;

end.




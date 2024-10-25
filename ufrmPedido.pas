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
  uPedido, Vcl.DBGrids, Vcl.Mask;

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
    GroupBox1: TGroupBox;
    edtCodProduto: TEdit;
    Label6: TLabel;
    edtDescricao: TEdit;
    Label7: TLabel;
    edtId: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label12: TLabel;
    edtQuantidade: TEdit;
    edtTotalPedido: TEdit;
    btnNovo: TButton;
    mtProdutoPedido: TFDMemTable;
    mtProdutoPedidoid: TIntegerField;
    mtProdutoPedidonumeropedido: TIntegerField;
    mtProdutoPedidocodproduto: TIntegerField;
    mtProdutoPedidodescricao: TStringField;
    mtProdutoPedidoquantidade: TCurrencyField;
    mtProdutoPedidovalorunitario: TCurrencyField;
    mtProdutoPedidovalortotal: TCurrencyField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    edtValorUnitario: TEdit;
    edtValorTotal: TEdit;
    btnGravar: TButton;
    Button1: TButton;
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
  private
    { Private declarations }
    APedido: TPedido;
    Acao: TAcao;
    function ConectarBanco: boolean;

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

procedure TfrmPedido.btnGravarClick(Sender: TObject);
begin

  APedido.Numero := StrToInt(edtNumero.Text);
  APedido.Emissao := Now;
  APedido.CodCliente := StrToInt(edtCodCliente.Text);
  APedido.RecordObject;
end;

procedure TfrmPedido.btnNovoClick(Sender: TObject);
begin
  edtCodCliente.SetFocus;
  edtNumero.Text := 'Novo';
  edtNumero.Enabled := false;
  LimparCliente;
  LimparProduto;
  APedido := TPedido.Create(fdConexao);
  Acao := Inclusao;
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

procedure TfrmPedido.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    DBGrid1DblClick(self);
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

procedure TfrmPedido.edtIdExit(Sender: TObject);
var
  AProdutoPedido: TProdutoPedido;
begin
  if Trim(edtId.Text) <> '' then
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
      APedido.Free;
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
    try
      if Apedido.SetObject(StrToInt(Trim(edtNumero.Text))) then
      begin
        edtCodCliente.Text := IntToStr(APedido.CodCliente);
        edtCodClienteExit(self);
        mtProdutoPedido.EmptyDataSet;
        AProdutoPedido.Create(fdConexao);
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
            mtProdutoPedidoquantidade.Value := AQuery.FieldByName('quantidade').AsCurrency;
            mtProdutoPedidovalorunitario.Value := AQuery.FieldByName('valorunitario').AsCurrency;
            mtProdutoPedidovalortotal.Value := AQuery.FieldByName('valortotal').AsCurrency;
            mtProdutoPedido.Post;
            AQuery.Next;
          end;
        finally
          AQuery.Free;
        end;
        Acao := Consulta;
      end
      else
      begin
        edtCodCliente.Text := '';
        LimparCliente;
        mtProdutoPedido.EmptyDataSet;
        ShowMessage('Pedido não encontrado');
        edtNumero.SetFocus;
        Acao := Nada;
      end;
    finally
      APedido.Free;
    end;
  end;
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
  Acao := Nada;
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


end.




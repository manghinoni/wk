unit uProduto;

interface

uses FireDAC.Comp.Client, System.SysUtils;

type
  {$M+}
  TProduto = class

    private
    FConnection: TFDConnection;
    FSQL: TFDQuery;
    FCodigo: integer;
    FDescricao: string;
    FPreco: currency;
    procedure SetCodigo(const Value: integer);
    procedure SetDescricao(const Value: string);
    procedure SetPreco(const Value: currency);

    protected

    public
      function SetObject(ACodigo: integer): boolean;
    published
      constructor Create(AConnection: TFDConnection);
      property Codigo: integer read FCodigo write SetCodigo;
      property Descricao: string read FDescricao write SetDescricao;
      property Preco: currency read FPreco write SetPreco;

  end;

implementation


constructor TProduto.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection := AConnection;
  FSQL := TFDQuery.Create(nil);
  FSQL.Connection := FConnection;
  FCodigo := 0;
  FDescricao := '';
  FPreco := 0;
end;

{ TCliente }

procedure TProduto.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;

procedure TProduto.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

function TProduto.SetObject(ACodigo: integer): boolean;
begin
  result := false;
  FSQL.SQL.Clear;
  FSQL.SQL.Add('select descricao, preco from produto where codigo = ' + IntToStr(ACodigo));
  FSQL.Open;
  if not FSQL.Eof then
  begin
    FCodigo := ACodigo;
    FDescricao := FSQL.FieldByName('descricao').AsString;
    FPreco := FSQL.FieldByName('preco').AsCurrency;
    Result := true;
  end;
  FSQL.Close;
end;

procedure TProduto.SetPreco(const Value: currency);
begin
  FPreco := Value;
end;

end.

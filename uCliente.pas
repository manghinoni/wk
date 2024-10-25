unit uCliente;

interface

uses FireDAC.Comp.Client, System.SysUtils;

type
  {$M+}
  TCliente = class

    private
    FConnection: TFDConnection;
    FSQL: TFDQuery;
    FUF: string;
    FCodigo: integer;
    FNome: string;
    FCidade: string;
    procedure SetCidade(const Value: string);
    procedure SetCodigo(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetUF(const Value: string);

    protected

    public
      function SetObject(ACodigo: integer): boolean;
    published
      constructor Create(AConnection: TFDConnection);
      property Codigo: integer read FCodigo write SetCodigo;
      property Nome: string read FNome write SetNome;
      property Cidade: string read FCidade write SetCidade;
      property UF: string read FUF write SetUF;

  end;

implementation

{ TCliente }

constructor TCliente.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection := AConnection;
  FSQL := TFDQuery.Create(nil);
  FSQL.Connection := FConnection;
  FUF := '';
  FCodigo := 0;
  FNome := '';
  FCidade := '';
end;

function TCliente.SetObject(ACodigo: integer): boolean;
begin
  result := false;
  FSQL.SQL.Clear;
  FSQL.SQL.Add('select nome, cidade, uf from cliente where codigo = ' + IntToStr(ACodigo));
  FSQL.Open;
  if not FSQL.Eof then
  begin
    FCodigo := ACodigo;
    FNome := FSQL.FieldByName('nome').AsString;
    FCidade := FSQL.FieldByName('cidade').AsString;
    FUF := FSQL.FieldByName('uf').AsString;
    Result := true;
  end;
  FSQL.Close;
end;

procedure TCliente.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TCliente.SetCodigo(const Value: integer);
begin
  FCodigo := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TCliente.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
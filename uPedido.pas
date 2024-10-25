unit uPedido;

interface

uses FireDAC.Comp.Client, System.SysUtils;

type
  {$M+}
  TPedido = class

    private
    FConnection: TFDConnection;
    FSQL: TFDQuery;
    FNumero: integer;
    FCodCliente: integer;
    FTotal: currency;
    FEmissao: TDate;
    procedure SetCodCliente(const Value: integer);
    procedure SetEmissao(const Value: TDate);
    procedure SetNumero(const Value: integer);
    procedure SetTotal(const Value: currency);

    protected

    public
      function SetObject(ANumero: integer): boolean;
      function RecordObject: boolean;
    published
      constructor Create(AConnection: TFDConnection);
      property Numero: integer read FNumero write SetNumero;
      property Emissao: TDate read FEmissao write SetEmissao;
      property CodCliente: integer read FCodCliente write SetCodCliente;
      property Total: currency read FTotal write SetTotal;

  end;

implementation

{ TPedido }

constructor TPedido.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection := AConnection;
  FSQL := TFDQuery.Create(nil);
  FSQL.Connection := FConnection;
  FNumero := 0;
  FCodCliente := 0;
  FTotal := 0;
  FEmissao := Now;
end;

function TPedido.RecordObject: boolean;
begin
  result := false;
  FSQL.SQL.Clear;
  FSQL.SQL.Add('insert into pedido ');
  FSQL.SQL.Add('(emissao, codcliente, total) ');
  FSQL.SQL.Add('values (:emissao, :codcliente, :total) ');
  FSQL.SQL.Add('returning numero ');
  FSQL.Open;
  if not FSQL.Eof then
  begin
    FNumero := FSQL.FieldByName('numero').AsInteger;
    Result := true;
  end;
  FSQL.Close;
end;

procedure TPedido.SetCodCliente(const Value: integer);
begin
  FCodCliente := Value;
end;

procedure TPedido.SetEmissao(const Value: TDate);
begin
  FEmissao := Value;
end;

procedure TPedido.SetNumero(const Value: integer);
begin
  FNumero := Value;
end;

function TPedido.SetObject(ANumero: integer): boolean;
begin
  result := false;
  FSQL.SQL.Clear;
  FSQL.SQL.Add('select emissao, codcliente, total from pedido where numero = ' + IntToStr(ANumero));
  FSQL.Open;
  if not FSQL.Eof then
  begin
    FNumero := ANumero;
    FEmissao := FSQL.FieldByName('emissao').AsDateTime;
    FCodCliente := FSQL.FieldByName('codcliente').AsInteger;
    FTotal := FSQL.FieldByName('total').AsCurrency;
    Result := true;
  end;
  FSQL.Close;
end;

procedure TPedido.SetTotal(const Value: currency);
begin
  FTotal := Value;
end;

end.

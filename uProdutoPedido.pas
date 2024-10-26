unit uProdutoPedido;

interface

uses FireDAC.Comp.Client, System.SysUtils, Firedac.Stan.Param;

type
  {$M+}
  TProdutoPedido = class

    private
    FConnection: TFDConnection;
    FSQL: TFDQuery;
    FNumeroPedido: integer;
    FID: integer;
    FCodProduto: integer;
    FValorUnitario: currency;
    FValorTotal: currency;
    FQuantidade: currency;

    procedure SetCodigoProduto(const Value: integer);
    procedure SetID(const Value: integer);
    procedure SetNumeroPedido(const Value: integer);
    procedure SetQuantidade(const Value: currency);
    procedure SetValorTotal(const Value: currency);
    procedure SetValorUnitario(const Value: currency);

    protected

    public
      function SetObject(AId: integer): boolean;
      procedure ListAllByPedido(APedido: integer; var AQuery: TFDQuery);
      procedure DeleteAllByPedido(APedido: integer);
      function RecordObject: boolean;
    published
      constructor Create(AConnection: TFDConnection);
      property ID: integer read FID write SetID;
      property NumeroPedido: integer read FNumeroPedido write SetNumeroPedido;
      property CodProduto: integer read FCodProduto write SetCodigoProduto;
      property Quantidade: currency read FQuantidade write SetQuantidade;
      property ValorUnitario: currency read FValorUnitario write SetValorUnitario;
      property ValorTotal: currency read FValorTotal write SetValorTotal;

  end;

implementation

{ TProdutoPedido }

constructor TProdutoPedido.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection := AConnection;
  FSQL := TFDQuery.Create(nil);
  FSQL.Connection := FConnection;
  FNumeroPedido := 0;
  FID := 0;
  FCodProduto := 0;
  FValorUnitario := 0;
  FValorTotal := 0;
  FQuantidade := 0;
end;

procedure TProdutoPedido.DeleteAllByPedido(APedido: integer);
begin
  FSQL.SQL.Clear;
  FSQL.SQL.Add('delete ');
  FSQL.SQL.Add('from produtopedido ');
  FSQL.SQL.Add('where numeropedido = ' + IntToStr(APedido) + ' ');
  FSQL.ExecSQL;
end;

procedure TProdutoPedido.ListAllByPedido(APedido: integer; var AQuery: TFDQuery);
begin
  FSQL.SQL.Clear;
  FSQL.SQL.Add('select pp.id, pp.numeropedido, pp.codproduto, p.descricao, pp.quantidade, pp.valorunitario, pp.valortotal ');
  FSQL.SQL.Add('from produtopedido pp ');
  FSQL.SQL.Add('inner join produto p on p.codigo = pp.codproduto ');
  FSQL.SQL.Add('where numeropedido = ' + IntToStr(APedido) + ' ');
  FSQL.SQL.Add('order by id ');
  FSQL.Open;
  Aquery := FSQL;
end;

function TProdutoPedido.RecordObject: boolean;
begin
  result := false;
  FSQL.SQL.Clear;
  if FId = 0 then
  begin
    FSQL.SQL.Add('insert into produtopedido ');
    FSQL.SQL.Add('(numeropedido, codproduto, quantidade, valorunitario, valortotal) ');
    FSQL.SQL.Add('values (:numeropedido, :codproduto, :quantidade, :valorunitario, :valortotal) ');
    FSQL.SQL.Add('returning id ');
    FSQL.ParamByName('numeropedido').AsInteger := FNumeroPedido;
    FSQL.ParamByName('codproduto').AsInteger := FCodProduto;
    FSQL.ParamByName('quantidade').AsCurrency := FQuantidade;
    FSQL.ParamByName('valorunitario').AsCurrency := FValorUnitario;
    FSQL.ParamByName('valortotal').AsCurrency := FValorTotal;
    FSQL.Open;
    if not FSQL.Eof then
    begin
      FId := FSQL.FieldByName('id').AsInteger;
      Result := true;
    end;
  end
  else
  begin
    FSQL.SQL.Add('update produtopedido ');
    FSQL.SQL.Add('set numeropedido := :numeropedido, ');
    FSQL.SQL.Add('codproduto := :codproduto, ');
    FSQL.SQL.Add('quantidade := :quantidade, ');
    FSQL.SQL.Add('valorunitario := :valorunitario, ');
    FSQL.SQL.Add('valortotal := :valortotal ');
    FSQL.SQL.Add('where id = :id ');

    FSQL.ParamByName('numeropedido').AsInteger := FNumeroPedido;
    FSQL.ParamByName('codproduto').AsInteger := FCodProduto;
    FSQL.ParamByName('quantidade').AsCurrency := FQuantidade;
    FSQL.ParamByName('valorunitario').AsCurrency := FValorUnitario;
    FSQL.ParamByName('valortotal').AsCurrency := FValorTotal;
    FSQL.ExecSQL;
  end;
  FSQL.Close;
end;

procedure TProdutoPedido.SetCodigoProduto(const Value: integer);
begin
  FCodProduto := Value;
end;

procedure TProdutoPedido.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TProdutoPedido.SetNumeroPedido(const Value: integer);
begin
  FNumeroPedido := Value;
end;

function TProdutoPedido.SetObject(AId: integer): boolean;
begin
  result := false;
  FSQL.SQL.Clear;
  FSQL.SQL.Add('select numeropedido, codproduto, quantidade, valorunitario, valortotal from produtopedido where id = ' + IntToStr(AId));
  FSQL.Open;
  if not FSQL.Eof then
  begin
    FId := AId;
    FNumeroPedido := FSQL.FieldByName('numeropedido').AsInteger;
    FCodProduto := FSQL.FieldByName('codproduto').AsInteger;
    FQuantidade := FSQL.FieldByName('quantidade').AsCurrency;
    FValorUnitario := FSQL.FieldByName('valorunitario').AsCurrency;
    FValorUnitario := FSQL.FieldByName('valortotal').AsCurrency;
    Result := true;
  end
  else
    FId := AId;
  FSQL.Close;
end;

procedure TProdutoPedido.SetQuantidade(const Value: currency);
begin
  FQuantidade := Value;
end;

procedure TProdutoPedido.SetValorTotal(const Value: currency);
begin
  FValorTotal := Value;
end;

procedure TProdutoPedido.SetValorUnitario(const Value: currency);
begin
  FValorUnitario := Value;
end;

end.

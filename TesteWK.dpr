program TesteWK;

uses
  Vcl.Forms,
  ufrmPedido in 'ufrmPedido.pas' {frmPedido},
  uCliente in 'uCliente.pas',
  uProduto in 'uProduto.pas',
  uPedido in 'uPedido.pas',
  uProdutoPedido in 'uProdutoPedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.Run;
end.

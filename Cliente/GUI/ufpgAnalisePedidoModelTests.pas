unit ufpgAnalisePedidoModelTests;

interface

uses
  ufpgModelTests;

type
   TffpgAnalisePedidoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsCdPedido: string;
  published
    property fpgCdPedido: string read FsCdPedido write FsCdPedido;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

end.


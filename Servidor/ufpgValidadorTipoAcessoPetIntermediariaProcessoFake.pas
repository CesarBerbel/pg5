unit ufpgValidadorTipoAcessoPetIntermediariaProcessoFake;

interface

uses
  SysUtils, Classes, ufpgValidadorTipoAcessoPetIntermediariaProcesso;

type
  TfpgValidadorTipoAcessoPetIntermediariaProcessoFake = class(
    TfpgValidadorTipoAcessoPetIntermediariaProcesso)
  private
    FsSigiloProcesso: WideString;
    FbUsuarioPossuiFuncaoSeg: boolean;
    FbAcessoPeloMagistrado: boolean;
  protected
    function PegarSigiloProcesso(const psCdProcesso: string): string; override;
    function TestarUsuarioPossuiFuncaoHabilitada: boolean; override;
    function TestarAcessoConcedidoPorMagistrado(const psCdProcesso: string): boolean; override;
  public
    property fpgSigiloProcesso: WideString read FsSigiloProcesso write FsSigiloProcesso;
    property fpgUsuarioPossuiFuncaoSeg: boolean read FbUsuarioPossuiFuncaoSeg   
      write FbUsuarioPossuiFuncaoSeg;
    property fpgAcessoPeloMagistrado: boolean read FbAcessoPeloMagistrado 
      write FbAcessoPeloMagistrado;
  end;

implementation


function TfpgValidadorTipoAcessoPetIntermediariaProcessoFake.PegarSigiloProcesso(
  const psCdProcesso: string): string;
begin
  result := fpgSigiloProcesso;
end;

function TfpgValidadorTipoAcessoPetIntermediariaProcessoFake.TestarUsuarioPossuiFuncaoHabilitada: boolean;
begin
  result := FbUsuarioPossuiFuncaoSeg;
end;

function TfpgValidadorTipoAcessoPetIntermediariaProcessoFake.TestarAcessoConcedidoPorMagistrado(
  const psCdProcesso: string): boolean;
begin
  result := FbAcessoPeloMagistrado;
end;

end.

unit ufpgProcessoAuditoriaListModelTests;

interface

uses
  uspDataModelTests;

type
  TfpgProcessoAuditoriaListModelTests = class(TspDataModelTests)
  private
    FscdProcesso: string;
    FnQtdeEtiquetas: integer;
    FnPosicaoLista: integer;
    /// <summary>
    ///  Método seta valor na propriedade
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 28/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure SetfpgcdProcesso(const Value: string);
    /// <summary>
    ///  Método seta valor na propriedade
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 28/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure SetfpgQtdeEtiquetas(const Value: integer);
    /// <summary>
    ///  Método seta valor na propriedade
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 28/08/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure SetfpgPosicaoLista(const Value: integer);
  published
    property fpgcdProcesso: string read FscdProcesso write SetfpgcdProcesso;
    property fpgQtdeEtiquetas: integer read FnQtdeEtiquetas write SetfpgQtdeEtiquetas;
    property fpgPosicaoLista: integer read FnPosicaoLista write SetfpgPosicaoLista;
  end;

implementation

// 28/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListModelTests.SetfpgcdProcesso(const Value: string);
begin
  if FscdProcesso = Value then
  begin
    Exit;
  end;

  FscdProcesso := Value;
end;

// 28/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListModelTests.SetfpgQtdeEtiquetas(const Value: integer);
begin
  if FnQtdeEtiquetas = Value then
  begin
    Exit;
  end;

  FnQtdeEtiquetas := Value;
end;

// 28/08/2014 - douglas.delapria - SALT: 145483/1
procedure TfpgProcessoAuditoriaListModelTests.SetfpgPosicaoLista(const Value: integer);
begin
  if FnPosicaoLista = Value then
  begin
    Exit;
  end;

  FnPosicaoLista := Value;
end;

end.


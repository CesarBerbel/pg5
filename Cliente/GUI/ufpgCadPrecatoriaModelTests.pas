unit ufpgCadPrecatoriaModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCadPrecatoriaModelTests = class(TfpgModelTests)
  private
    FsClasseExt: string;
    FsCompetencia: string;
    FsArea: string;
    FsAssuntoPrincipal: string;
    FsTipoDistribuicao: string;
    FsGrj: string;
    FsVolumes: string;
    FsFolhas: string;
    FsValoracao: string;
    FsDataValoracao: string;
    FsMunicipio: string;
    FsRecebimento: string;
    FsTipoSigilo: string;
    FsComarca: string;
    FsJuizo: string;
    FsNuOrigem: string;
    FsClasseOrigem: string;
    FsObjetoPrecatoria: string;
    FsComplementoObjeto: string;
    FsPrazoDias: string;
    FsDataCumprimentoPrecatoria: string;
  published
    property fpgClasseExt: string read FsClasseExt write FsClasseExt;
    property fpgCompetencia: string read FsCompetencia write FsCompetencia;
    property fpgArea: string read FsArea write FsArea;
    property fpgAssuntoPrincipal: string read FsAssuntoPrincipal write FsAssuntoPrincipal;
    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
    property fpgGrj: string read FsGrj write FsGrj;
    property fpgVolumes: string read FsVolumes write FsVolumes;
    property fpgFolhas: string read FsFolhas write FsFolhas;
    property fpgValoracao: string read FsValoracao write FsValoracao;
    property fpgDataValoracao: string read FsDataValoracao write FsDataValoracao;
    property fpgMunicipio: string read FsMunicipio write FsMunicipio;
    property fpgRecebimento: string read FsRecebimento write FsRecebimento;
    property fpgTipoSigilo: string read FsTipoSigilo write FsTipoSigilo;
    property fpgComarca: string read FsComarca write FsComarca;
    property fpgJuizo: string read FsJuizo write FsJuizo;
    property fpgNuOrigem: string read FsNuOrigem write FsNuOrigem;
    property fpgClasseOrigem: string read FsClasseOrigem write FsClasseOrigem;
    property fpgObjetoPrecatoria: string read FsObjetoPrecatoria write FsObjetoPrecatoria;
    property fpgComplementoObjeto: string read FsComplementoObjeto write FsComplementoObjeto;
    property fpgPrazoDias: string read FsPrazoDias write FsPrazoDias;
    property fpgDataCumprimentoPrecatoria: string 
      read FsDataCumprimentoPrecatoria   write FsDataCumprimentoPrecatoria;
  end;

implementation

end.


program Starter;

uses
  Vcl.Forms,
  btu.sta.ui.PrincForm in 'ui\btu.sta.ui.PrincForm.pas' {PrincForm},
  sta.exec_u in 'sta\sta.exec_u.pas',
  btu.sta.ui.ConfigForm in 'ui\btu.sta.ui.ConfigForm.pas' {StarterFormConfig},
  ControlsReposition in '..\bantu-lib\sis\ui\FormDecorators\ControlsAlign\ControlsReposition.pas',
  btu.sta.MaqNomeEdFrame in 'ui\btu.sta.MaqNomeEdFrame.pas' {MaqNomeEdFrame: TFrame},
  sis.ui.Img.DataModule in '..\bantu-lib\sis\ui\FormDecorators\sis.ui.Img.DataModule.pas' {SisImgDataModule: TDataModule},
  btu.lib.config.machineid in '..\bantu-lib\sis\config\btu.lib.config.machineid.pas',
  btu.lib.config in '..\bantu-lib\sis\config\btu.lib.config.pas',
  btu.lib.config.machineid_u in '..\bantu-lib\sis\config\btu.lib.config.machineid_u.pas',
  btu.lib.config_u in '..\bantu-lib\sis\config\btu.lib.config_u.pas',
  btu.lib.config.factory in '..\bantu-lib\sis\config\btu.lib.config.factory.pas',
  winversion in '..\bantu-lib\sis\win\winversion.pas',
  winplatform in '..\bantu-lib\sis\win\winplatform.pas',
  Sis.Files in '..\bantu-lib\sis\files\Sis.Files.pas',
  sis.win.VersionInfo in '..\bantu-lib\sis\win\sis.win.VersionInfo.pas',
  sis.win.VersionInfo_u in '..\bantu-lib\sis\win\sis.win.VersionInfo_u.pas',
  sis.win.factory in '..\bantu-lib\sis\win\sis.win.factory.pas',
  sis.sis.constants in '..\bantu-lib\sis\sis\sis.sis.constants.pas',
  sis.types.constants in '..\bantu-lib\sis\types\sis.types.constants.pas',
  sis.win.constants in '..\bantu-lib\sis\win\sis.win.constants.pas',
  sta.constants in 'sta\sta.constants.pas',
  btu.sis.di.ui.constants in '..\bantu-lib\sis\di\ui\btu.sis.di.ui.constants.pas',
  sis.types.strings in '..\bantu-lib\sis\types\str\sis.types.strings.pas',
  btu.lib.usu.Usuario in '..\bantu-lib\sis\usu\btu.lib.usu.Usuario.pas',
  btu.lib.usu.Usuario_u in '..\bantu-lib\sis\usu\btu.lib.usu.Usuario_u.pas',
  btu.lib.usu.factory in '..\bantu-lib\sis\usu\btu.lib.usu.factory.pas',
  btu.lib.debug in '..\bantu-lib\sis\debug\btu.lib.debug.pas',
  sis.ui.controls.utils in '..\bantu-lib\sis\ui\controls\sis.ui.controls.utils.pas',
  btu.lib.lists.HashItem_i in '..\bantu-lib\sis\lists\btu.lib.lists.HashItem_i.pas',
  btu.lib.lists.HashItem_u in '..\bantu-lib\sis\lists\btu.lib.lists.HashItem_u.pas',
  btu.lib.lists.HashItemList_i in '..\bantu-lib\sis\lists\btu.lib.lists.HashItemList_i.pas',
  btu.lib.lists.HashItemList_u in '..\bantu-lib\sis\lists\btu.lib.lists.HashItemList_u.pas',
  btu.lib.lists.IdItem in '..\bantu-lib\sis\lists\btu.lib.lists.IdItem.pas',
  btu.lib.lists.IdItemList_i in '..\bantu-lib\sis\lists\btu.lib.lists.IdItemList_i.pas',
  btu.lib.lists.IdItemList_u in '..\bantu-lib\sis\lists\btu.lib.lists.IdItemList_u.pas',
  btu.lib.lists.factory in '..\bantu-lib\sis\lists\btu.lib.lists.factory.pas',
  btu.lib.lists.IdItem_u in '..\bantu-lib\sis\lists\btu.lib.lists.IdItem_u.pas',
  btu.lib.entit.loja in '..\bantu-lib\sis\entit\btu.lib.entit.loja.pas',
  btu.lib.entit.loja_u in '..\bantu-lib\sis\entit\btu.lib.entit.loja_u.pas',
  btu.lib.entit.factory in '..\bantu-lib\sis\entit\btu.lib.entit.factory.pas',
  sis.ui.io.output in '..\bantu-lib\sis\ui\io\output\sis.ui.io.output.pas',
  sis.ui.io.log in '..\bantu-lib\sis\ui\io\log\sis.ui.io.log.pas',
  sis.ui.io.log_u in '..\bantu-lib\sis\ui\io\log\sis.ui.io.log_u.pas',
  sis.ui.io.output.mudo_u in '..\bantu-lib\sis\ui\io\output\sis.ui.io.output.mudo_u.pas',
  sis.ui.io.log.LogFile_u in '..\bantu-lib\sis\ui\io\log\sis.ui.io.log.LogFile_u.pas',
  sis.ui.io.log.LogRecord in '..\bantu-lib\sis\ui\io\log\sis.ui.io.log.LogRecord.pas',
  sis.ui.io.log.LogRecord_u in '..\bantu-lib\sis\ui\io\log\sis.ui.io.log.LogRecord_u.pas',
  sis.ui.io.log.factory in '..\bantu-lib\sis\ui\io\log\sis.ui.io.log.factory.pas',
  sis.types.bool.utils in '..\bantu-lib\sis\types\bool\sis.types.bool.utils.pas',
  sis.win.pastas in '..\bantu-lib\sis\win\sis.win.pastas.pas',
  btu.lib.db.firebird.utils in '..\bantu-lib\sis\db\firebird\btu.lib.db.firebird.utils.pas',
  btu.lib.db.firebird.types in '..\bantu-lib\sis\db\firebird\btu.lib.db.firebird.types.pas',
  btu.lib.db.types in '..\bantu-lib\sis\db\btu.lib.db.types.pas',
  btu.lib.db.factory in '..\bantu-lib\sis\db\btu.lib.db.factory.pas',
  btu.lib.db.dbms.info_u in '..\bantu-lib\sis\db\dbms\btu.lib.db.dbms.info_u.pas',
  sis.win.registry in '..\bantu-lib\sis\win\registry\sis.win.registry.pas',
  Sta.Exec.Testes_u in 'sta\Testes\Sta.Exec.Testes_u.pas',
  Sta.Exec.Testes.Reg_u in 'sta\Testes\Sta.Exec.Testes.Reg_u.pas',
  FDacDM_u in '..\bantu-lib\sis\db\fdac_acces\FDacDM_u.pas' {FDacDM: TDataModule},
  sis.win.execute in '..\bantu-lib\sis\win\sis.win.execute.pas',
  sis.win.execute_u in '..\bantu-lib\sis\win\sis.win.execute_u.pas',
  sis.sis.Executavel in '..\bantu-lib\sis\sis\sis.sis.Executavel.pas',
  sis.sis.Executavel_u in '..\bantu-lib\sis\sis\sis.sis.Executavel_u.pas',
  sis.ui.io.output.form_u in '..\bantu-lib\sis\ui\io\output\output.form\sis.ui.io.output.form_u.pas' {OutputForm},
  sis.ui.io.output.toform_u in '..\bantu-lib\sis\ui\io\output\output.form\sis.ui.io.output.toform_u.pas',
  sis.ui.io.factory in '..\bantu-lib\sis\ui\io\sis.ui.io.factory.pas',
  btu.lib.db.updater in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.pas',
  btu.lib.db.updater_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater_u.pas',
  btu.lib.db.updater.factory in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.factory.pas',
  btu.lib.db.updater.firebird_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.firebird_u.pas',
  btu.lib.db.firebird.info in '..\bantu-lib\sis\db\firebird\btu.lib.db.firebird.info.pas',
  btu.lib.db.dbms in '..\bantu-lib\sis\db\dbms\btu.lib.db.dbms.pas',
  btu.lib.db.dbms.firebird_u in '..\bantu-lib\sis\db\dbms\btu.lib.db.dbms.firebird_u.pas',
  sis.types.integers in '..\bantu-lib\sis\types\int\sis.types.integers.pas',
  btu.lib.db.connection.firedac_u in '..\bantu-lib\sis\db\dbconnect\btu.lib.db.connection.firedac_u.pas',
  btu.lib.db.connection_u in '..\bantu-lib\sis\db\dbconnect\btu.lib.db.connection_u.pas',
  sis.types.str.TStrings_u in '..\bantu-lib\sis\types\str\sis.types.str.TStrings_u.pas',
  btu.lib.db.query_u in '..\bantu-lib\sis\db\dbconnect\btu.lib.db.query_u.pas',
  btu.lib.db.sqloperation_u in '..\bantu-lib\sis\db\dbconnect\btu.lib.db.sqloperation_u.pas',
  btu.lib.db.query.firedac_u in '..\bantu-lib\sis\db\dbconnect\btu.lib.db.query.firedac_u.pas',
  btu.sis.db.updater.utils in '..\bantu-lib\sis\db\updater\btu.sis.db.updater.utils.pas',
  btu.lib.db.updater.firebird.GetSql_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.firebird.GetSql_u.pas',
  btu.lib.db.updater.campo in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.campo.pas',
  btu.lib.db.updater.comando.fb.createtable_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.fb.createtable_u.pas',
  btu.lib.db.updater.campo_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.campo_u.pas',
  btu.lib.db.updater.comando in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.pas',
  btu.lib.db.updater.constants_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.constants_u.pas',
  btu.lib.db.updater.campo.list in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.campo.list.pas',
  btu.lib.db.updater.campo.list_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.campo.list_u.pas',
  btu.lib.db.updater.comando.fb.createoralterprocedure_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.fb.createoralterprocedure_u.pas',
  btu.lib.db.updater.comando.list in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.list.pas',
  btu.lib.db.updater.comando.list_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.list_u.pas',
  btu.lib.db.updater.comando.fb_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.fb_u.pas',
  sis.ui.io.output.exibirpausa.form_u in '..\bantu-lib\sis\ui\io\output\output.form\sis.ui.io.output.exibirpausa.form_u.pas' {ExibirPausaF},
  btu.lib.db.exec_u in '..\bantu-lib\sis\db\dbconnect\btu.lib.db.exec_u.pas',
  btu.lib.db.exec.firedac_u in '..\bantu-lib\sis\db\dbconnect\btu.lib.db.exec.firedac_u.pas',
  Sta.Exec.Testes.Strings_u in 'sta\Testes\Sta.Exec.Testes.Strings_u.pas',
  btu.lib.db.updater.operations in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.operations.pas',
  btu.lib.db.updater.operations.fb_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.operations.fb_u.pas',
  btu.lib.db.updater.comando.fb.createoralterpackage_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.fb.createoralterpackage_u.pas',
  btu.lib.db.firebird.GetSql in '..\bantu-lib\sis\db\firebird\btu.lib.db.firebird.GetSql.pas',
  btu.lib.db.updater.comando.fb.createdomains_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.fb.createdomains_u.pas',
  sis.sis.clipb_u in '..\bantu-lib\sis\sis\sis.sis.clipb_u.pas',
  btu.lib.db.dbms.config in '..\bantu-lib\sis\db\dbms\btu.lib.db.dbms.config.pas',
  btu.lib.db.dbms.config_u in '..\bantu-lib\sis\db\dbms\btu.lib.db.dbms.config_u.pas',
  btu.lib.db.dbms.config.firebird_u in '..\bantu-lib\sis\db\dbms\btu.lib.db.dbms.config.firebird_u.pas',
  Sta.Exec.Testes.CSV_u in 'sta\Testes\Sta.Exec.Testes.CSV_u.pas',
  btu.lib.db.updater.comando.fb.ensurerecords_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.fb.ensurerecords_u.pas',
  btu.lib.lists.TextoItem in '..\bantu-lib\sis\lists\TextList\btu.lib.lists.TextoItem.pas',
  btu.lib.lists.TextoItem_u in '..\bantu-lib\sis\lists\TextList\btu.lib.lists.TextoItem_u.pas',
  btu.lib.lists.TextoList in '..\bantu-lib\sis\lists\TextList\btu.lib.lists.TextoList.pas',
  btu.lib.lists.TextoList_u in '..\bantu-lib\sis\lists\TextList\btu.lib.lists.TextoList_u.pas',
  btu.lib.db.updater.comando.fb.createsequence_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.fb.createsequence_u.pas',
  btu.lib.db.updater.comando.fb.createforeignkey_u in '..\bantu-lib\sis\db\updater\btu.lib.db.updater.comando.fb.createforeignkey_u.pas',
  btu.lib.lists.LojaTermIdItem in '..\bantu-lib\sis\lists\btu.lib.lists.LojaTermIdItem.pas',
  btu.lib.lists.LojaTermIdItem_u in '..\bantu-lib\sis\lists\btu.lib.lists.LojaTermIdItem_u.pas',
  btu.lib.entit.LojaTermId.utils in '..\bantu-lib\sis\entit\usuario\btu.lib.entit.LojaTermId.utils.pas',
  sis.types.strings.crypt in '..\bantu-lib\sis\types\str\sis.types.strings.crypt.pas',
  Sta.Exec.Testes.Crypt_u in 'sta\Testes\Sta.Exec.Testes.Crypt_u.pas',
  sis.win.execs in '..\bantu-lib\sis\win\sis.win.execs.pas',
  sis.types.floats in '..\bantu-lib\sis\types\float\sis.types.floats.pas',
  btu.lib.config.xmli in '..\bantu-lib\sis\config\btu.lib.config.xmli.pas',
  btu.lib.config.xmli_u in '..\bantu-lib\sis\config\btu.lib.config.xmli_u.pas',
  btu.sta.ui.ConfigForm.testeconfig in 'ui\btu.sta.ui.ConfigForm.testeconfig.pas',
  sis.files.factory in '..\bantu-lib\sis\files\sis.files.factory.pas',
  sis.files.FileInfo_u in '..\bantu-lib\sis\files\sis.files.FileInfo_u.pas',
  sis.files.FileInfo in '..\bantu-lib\sis\files\sis.files.FileInfo.pas',
  Sis.Files.Sync in '..\bantu-lib\sis\files\Sis.Files.Sync.pas';

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  Application.MainFormOnTaskbar := False;
//  Application.ShowMainForm := False;
  Application.ShowMainForm := True;
  Application.CreateForm(TPrincForm, PrincForm);
  Application.Run;
end.

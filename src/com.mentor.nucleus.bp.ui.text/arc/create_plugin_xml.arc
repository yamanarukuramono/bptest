.//=====================================================================
.//
.// File:      $RCSfile: create_plugin_xml.arc,v $
.// Version:   $Revision: 1.98 $
.// Modified:  $Date: 2013/06/24 14:49:07 $
.//
.// (c) Copyright 2006-2014 by Mentor Graphics Corp. All rights reserved.
.//
.//=====================================================================
.// Licensed under the Apache License, Version 2.0 (the "License"); you may not
.// use this file except in compliance with the License.  You may obtain a copy
.// of the License at
.//
.//      http://www.apache.org/licenses/LICENSE-2.0
.//
.// Unless required by applicable law or agreed to in writing, software
.// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
.// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   See the
.// License for the specific language governing permissions and limitations under
.// the License.
.//=====================================================================
.//
.// This archetype is responsible for creating the plugin.xml
.// file for com.mentor.nucleus.bp.ui.text.
.//
.//
.// ------------------------------------------------------------
.// Main code
.// -------------------------------------------------------------
.//
.include "arc/create_util.inc"
.//
.assign path = "com.mentor.nucleus.bp.ui.text"
.//
.invoke result = get_editor_obj_set()
.assign dsc_obj_set = result.dsc_obj_set
.assign oal_obj_set = result.oal_obj_set
.assign canvas_dsc_obj_set = result.canvas_dsc_obj_set
.assign canvas_oal_obj_set = result.canvas_oal_obj_set
.//
<?xml version="1.0" encoding="UTF-8"?>
<?eclipse version="3.0"?>
<!--
===================================================================

File: ${path}/plugin.xml

WARNING:      Do not edit this generated file
Generated by: ${info.arch_file_name}
Version:      $$Revision: 1.98 $$

Copyright (c) 2006-2014 Mentor Graphics CorporationMentor Graphics CorporationMentor Graphics CorporationMentor Graphics CorporationMentor Graphics CorporationMentor Graphics Corporationby Mentor Graphics Corp.  All rights reserved.

===================================================================
Licensed under the Apache License, Version 2.0 (the "License"); you may not 
use this file except in compliance with the License.  You may obtain a copy 
of the License at

      http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT 
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   See the 
License for the specific language governing permissions and limitations under
the License.
===================================================================

This file is the plugin manifest for the BridgePoint core plugin.

===================================================================
-->
<plugin
   id="com.mentor.nucleus.bp.ui.text"
   name="BridgePoint Text Plug-in"
   version="4.2.1"
   provider-name="Mentor Graphics"
   class="com.mentor.nucleus.bp.ui.text.TextPlugin">

   <runtime>
      <library name="text.jar">
         <export name="*"/>
      </library>
   </runtime>
   <requires>
      <import plugin="org.eclipse.core.runtime"/>
      <import plugin="org.eclipse.ui"/>
      <import plugin="org.eclipse.core.resources"/>
      <import plugin="com.mentor.nucleus.bp.core"/>
      <import plugin="com.mentor.nucleus.bp.als.oal"/>
      <import plugin="org.eclipse.ui.workbench.texteditor"/>
      <import plugin="org.antlr"/>
      <import plugin="org.eclipse.jface.text"/>
      <import plugin="org.eclipse.core.boot"/>
      <import plugin="org.eclipse.ui.views"/>
      <import plugin="org.eclipse.ui.editors"/>
      <import plugin="org.eclipse.ui.ide"/>
   </requires>

   <extension point = "org.eclipse.ui.elementFactories">
       <factory id ="com.mentor.nucleus.bp.ui.text.activity.factory" class="com.mentor.nucleus.bp.ui.text.activity.ActivityEditorInputFactory"/>
       <factory id ="com.mentor.nucleus.bp.ui.text.description.factory" class="com.mentor.nucleus.bp.ui.text.description.DescriptionEditorInputFactory"/>
   </extension>

   <extension
         point="org.eclipse.ui.editors">
      <editor
            name="Description Editor"
            icon="platform:/plugin/com.mentor.nucleus.bp.core/icons/edit_dsc.gif"
            extensions="dsc"
            contributorClass="org.eclipse.ui.texteditor.BasicTextEditorActionContributor"
            class="com.mentor.nucleus.bp.ui.text.description.DescriptionEditor"
            id="com.mentor.nucleus.bp.ui.text.description.DescriptionEditor">
      </editor>
   </extension>
   <extension
         point="org.eclipse.ui.editors">
      <editor
            name="Activity Editor"
            default="true"
            icon="platform:/plugin/com.mentor.nucleus.bp.core/icons/edit_oal.gif"
            extensions="oal"
            contributorClass="org.eclipse.ui.texteditor.BasicTextEditorActionContributor"
            class="com.mentor.nucleus.bp.ui.text.activity.ActivityEditor"
            id="com.mentor.nucleus.bp.ui.text.activity.ActivityEditor">
      </editor>
   </extension>

   <extension
         point="org.eclipse.ui.preferencePages">
       <page
           category="com.mentor.nucleus.bp.core.root"
           id="com.mentor.nucleus.bp.ui.text.editor.oal.preference.OALEditorPreferencesPage"
           class="com.mentor.nucleus.bp.ui.text.editor.oal.preference.OALEditorPreferencesPage"
            name="Activity Editor">
       </page>
   </extension>

   <extension
         id="com.mentor.nucleus.bp.ui.text.DescriptionEditorAction"
         name="Description Editor"
         point="org.eclipse.ui.popupMenus">
.assign index = 0
.for each obj in dsc_obj_set
  .select any clr_obj from instances of NAV_OBJ where (selected.src_key_lett == obj.key_lett)
  .if (not_empty clr_obj)
    .select any obj from instances of O_OBJ where (selected.key_lett == clr_obj.tgt_key_lett)
  .end if
  .assign index = index + 1
      <objectContribution
            objectClass="com.mentor.nucleus.bp.core.$cr{obj.name}_c"
            adaptable="true"
            id="com.mentor.nucleus.bp.ui.text.contribution${index}">
         <action
               label="Description Editor"
               icon="platform:/plugin/com.mentor.nucleus.bp.core/icons/edit_dsc.gif"
               class="com.mentor.nucleus.bp.ui.text.description.ShowDescriptionAction"
               menubarPath="com.mentor.nucleus.bp.ui.openroot/com.mentor.nucleus.bp.ui.openmenu"
               enablesFor="1"
               id="com.mentor.nucleus.bp.ui.text.description.ShowDescriptionEditorAction${index}">
         </action>
      </objectContribution>
.end for
   </extension>
   <extension
         id="com.mentor.nucleus.bp.ui.text.ActivityEditorAction"
         name="Activity Editor"
         point="org.eclipse.ui.popupMenus">
.assign index = 0
.for each obj in oal_obj_set
  .select any clr_obj from instances of NAV_OBJ where (selected.src_key_lett == obj.key_lett)
  .if (not_empty clr_obj)
    .select any obj from instances of O_OBJ where (selected.key_lett == clr_obj.tgt_key_lett)
  .end if
  .assign index = index + 1
      <objectContribution
            objectClass="com.mentor.nucleus.bp.core.$cr{obj.name}_c"
            adaptable="true"
            id="com.mentor.nucleus.bp.ui.text.contribution${index}">
         <action
               label="Activity Editor"
               icon="platform:/plugin/com.mentor.nucleus.bp.core/icons/edit_oal.gif"
               class="com.mentor.nucleus.bp.ui.text.activity.ShowActivityAction"
               menubarPath="com.mentor.nucleus.bp.ui.openroot/com.mentor.nucleus.bp.ui.openmenu"
               enablesFor="1"
               id="com.mentor.nucleus.bp.ui.text.activity.ShowActivityEditorAction${index}">
         </action>
  .if ( obj.Key_Lett == "O_ATTR" )
    .// only show this contribution if it is a derived attribute
         <filter name="subtype" value="O_DBATTR" />
  .end if
      </objectContribution>
.end for
   </extension>
   <extension
         id="com.mentor.nucleus.bp.ui.text.editors"
         name="Text Editors"
         point="com.mentor.nucleus.bp.core.editors">
      <editor
            input="com.mentor.nucleus.bp.ui.text.activity.ActivityEditorInput"
            class="com.mentor.nucleus.bp.ui.text.activity.ActivityEditor">
.assign dflt_oal_obj_set = oal_obj_set
.assign dflt_oal_obj_set = dflt_oal_obj_set - canvas_oal_obj_set
.select any attribute_class from instances of O_OBJ where selected.Key_Lett == "O_ATTR"
.assign dflt_oal_obj_set = dflt_oal_obj_set
.assign index = 0
.for each obj in dflt_oal_obj_set
  .select any clr_obj from instances of NAV_OBJ where (selected.src_key_lett == obj.key_lett)
  .if (not_empty clr_obj)
    .select any obj from instances of O_OBJ where (selected.key_lett == clr_obj.tgt_key_lett)
  .end if
  .assign index = index + 1
         <defaultFor class="com.mentor.nucleus.bp.core.$cr{obj.name}_c"
             modelType="" name="" ooaType="" />
.end for
      </editor>
      <editor
            input="com.mentor.nucleus.bp.ui.text.description.DescriptionEditorInput"
            class="com.mentor.nucleus.bp.ui.text.description.DescriptionEditor">
.assign dflt_dsc_obj_set = dsc_obj_set
.assign dflt_dsc_obj_set = dflt_dsc_obj_set - canvas_dsc_obj_set
.assign dflt_dsc_obj_set = dflt_dsc_obj_set - oal_obj_set
.// the attribute class can only have one default, and it's the description editor
.assign dflt_dsc_obj_set = dflt_dsc_obj_set | attribute_class
.assign index = 0
.for each obj in dflt_dsc_obj_set
  .select any clr_obj from instances of NAV_OBJ where (selected.src_key_lett == obj.key_lett)
  .if (not_empty clr_obj)
    .select any obj from instances of O_OBJ where (selected.key_lett == clr_obj.tgt_key_lett)
  .end if
  .assign index = index + 1
         <defaultFor class="com.mentor.nucleus.bp.core.$cr{obj.name}_c"
             modelType="" name="" ooaType="" />
.end for
      </editor>
   </extension>
   <extension
         id="com.mentor.nucleus.bp.ui.explorer.viewer"
         name="Model Explorer"
         point="org.eclipse.ui.popupMenus">
      <objectContribution
            adaptable="true"
            objectClass="com.mentor.nucleus.bp.core.Domain_c"
            id="com.mentor.nucleus.bp.ui.text.ParseAllActionDomain">
         <action
               label="Parse All Activities"
               class="com.mentor.nucleus.bp.ui.text.activity.ParseAllActivitiesAction"
               menubarPath="com.mentor.nucleus.bp.ui.context-internal"
               enablesFor="*"
               id="com.mentor.nucleus.bp.ui.text.ParseAllAction">
         </action>
      </objectContribution>
      <objectContribution
            adaptable="true"
            objectClass="com.mentor.nucleus.bp.core.Component_c"
            id="com.mentor.nucleus.bp.ui.text.ParseAllActionComponent">
         <action
               label="Parse All Activities"
               class="com.mentor.nucleus.bp.ui.text.activity.ParseAllActivitiesAction"
               menubarPath="com.mentor.nucleus.bp.ui.context-internal"
               enablesFor="*"
               id="com.mentor.nucleus.bp.ui.text.ParseAllAction">
         </action>
      </objectContribution>
      <objectContribution
            adaptable="true"
            objectClass="com.mentor.nucleus.bp.core.Package_c"
            id="com.mentor.nucleus.bp.ui.text.ParseAllActionPackage">
         <action
               label="Parse All Activities"
               class="com.mentor.nucleus.bp.ui.text.activity.ParseAllActivitiesAction"
               menubarPath="com.mentor.nucleus.bp.ui.context-internal"
               enablesFor="*"
               id="com.mentor.nucleus.bp.ui.text.ParseAllAction">
         </action>
      </objectContribution>
   </extension>
   <extension
      point="org.eclipse.help.contexts">
        <contexts file="contexts/contexts.xml"/>
   </extension>
   <extension
         point="org.eclipse.team.core.ignore">
      <ignore
            enabled="true"
            pattern="*.dsc"/>
      <ignore
            enabled="true"
            pattern="*.oal"/>
   </extension>
</plugin>
.//
.emit to file "plugin.xml"
.//

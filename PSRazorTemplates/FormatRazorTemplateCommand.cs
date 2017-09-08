using System;
using System.Collections.Immutable;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Internal;
using RazorLight;
using RazorLight.Extensions;

namespace PSRazorTemplates
{
    [Cmdlet(VerbsCommon.Format, "RazorTemplate", DefaultParameterSetName = Constants.DefaultParameterSet)]
    public class FormatRazorTemplateCommand : PSCmdlet
    {
        [Parameter(Mandatory = false, HelpMessage = "The path to the views folder.")]
        [ValidateNotNull]
        public DirectoryInfo ViewPath { get; set; }

        [Parameter( ValueFromPipeline = true, HelpMessage = "The ")]
        public PSObject InputObject { get; set; } = AutomationNull.Value;

        [Parameter(Position = 0, ParameterSetName = Constants.AdHocViewParameterSet, HelpMessage = "A string in Razor syntax representing the view to render.")]
        public string ViewString { get; set; }

        [Parameter(Position = 0, ParameterSetName = Constants.DefaultParameterSet, HelpMessage = "The name of a Razor file in the specified ViewPath to render the model(s) against.")]
        public string ViewName { get; set; }


        private IRazorLightEngine _Engine;

        private readonly ImmutableList<ExpandoObject>.Builder _ModelListBuilder = ImmutableList.CreateBuilder<ExpandoObject>();
        private ImmutableList<ExpandoObject> _Models;

        protected override void BeginProcessing()
        {
            if ( ViewPath == null )
                ViewPath = new DirectoryInfo( SessionState.Path.CurrentFileSystemLocation.Path );

            _Engine = EngineFactory.CreatePhysical( ViewPath.FullName );

        }

        protected override void ProcessRecord()
        {
            if ( !Equals( InputObject, AutomationNull.Value ) &&
                 InputObject != null )
            {
                // Convert each object on the pipeline to an ExpandoObject
                _ModelListBuilder.Add( InputObject.ToExpando());
            }
        }

        protected override void EndProcessing()
        {
            _Models = _ModelListBuilder.ToImmutable();

            if (_Models.Any() == false) return;

            string output;

            try
            {
                if ( ParameterSetName.Equals( Constants.AdHocViewParameterSet ) )
                {
                    output = _Models.Count == 1
                        ? _Engine.ParseString( ViewString, _Models.First() )
                        : _Engine.ParseString( ViewString, _Models.ToList() );
                }
                else
                {
                    output = _Models.Count == 1
                        ? _Engine.Parse( ViewName, _Models.First() )
                        : _Engine.Parse( ViewName, _Models.ToList() );

                }
            }
            catch ( Exception exception )
            {
                ThrowTerminatingError( new ErrorRecord(exception, "RazorEngineParsingError", ErrorCategory.OperationStopped, _Engine));
                return;
            }

            WriteObject(output);
        }
    }
}
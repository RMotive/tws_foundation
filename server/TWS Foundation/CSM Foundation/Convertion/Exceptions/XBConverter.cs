using System.Net;

using CSM_Foundation.Core.Bases;

namespace CSM_Foundation.Convertion.Exceptions;

/// <summary>
/// 
/// </summary>
public enum XBConverterSituations {
    /// <summary>
    /// 
    /// </summary>
    NoDiscriminator,    
}

/// <summary>
/// 
/// </summary>
public class XBConverter
    : BException<XBConverterSituations> {

    /// <summary>
    /// 
    /// </summary>
    /// <param name="Subject"></param>
    /// <param name="Status"></param>
    /// <param name="System"></param>
    public XBConverter(XBConverter) 
        : base(Subject, Status, System) {


    }
}

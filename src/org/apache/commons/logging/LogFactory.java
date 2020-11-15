/*
 * Copyright 2001-2006 The Apache Software Foundation.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.commons.logging;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

/**
 * LogFactory using log4j without all the classloader trick of commons logging.
 * Modified by Quentin Anciaux 12/06/2007
 */
public class LogFactory {
	private static class CLog implements Log {
		private final Logger log;

		public CLog(final String name) {
			this.log = Logger.getLogger(name);
		}

		public void debug(final Object message) {
			this.log.debug(message);
		}

		public void debug(final Object message, final Throwable t) {
			this.log.debug(message, t);
		}

		public boolean equals(Object obj) {
			if (obj instanceof CLog) {
				return ((CLog) obj).log.equals(this.log);
			}
			return false;
		}

		public void error(final Object message) {
			this.log.error(message);
		}

		public void error(final Object message, final Throwable t) {
			this.log.debug(message, t);
		}

		public void fatal(final Object message) {
			this.log.fatal(message);
		}

		public void fatal(final Object message, final Throwable t) {
			this.log.fatal(message, t);
		}

		public int hashCode() {
			return this.log.hashCode();
		}

		public void info(final Object message) {
			this.log.info(message);
		}

		public void info(final Object message, final Throwable t) {
			this.log.info(message, t);
		}

		public boolean isDebugEnabled() {
			return this.log.isDebugEnabled();
		}

		public boolean isErrorEnabled() {
			return this.log.isEnabledFor(Level.ERROR);
		}

		public boolean isFatalEnabled() {
			return this.log.isEnabledFor(Level.FATAL);
		}

		public boolean isInfoEnabled() {
			return this.log.isEnabledFor(Level.INFO);
		}

		public boolean isTraceEnabled() {
			return this.log.isEnabledFor(Level.TRACE);
		}

		public boolean isWarnEnabled() {
			return this.log.isEnabledFor(Level.WARN);
		}

		public String toString() {
			return this.log.toString();
		}

		public void trace(final Object message) {
			this.log.trace(message);
		}

		public void trace(final Object message, final Throwable t) {
			this.log.trace(message, t);
		}

		public void warn(final Object message) {
			this.log.warn(message);
		}

		public void warn(final Object message, final Throwable t) {
			this.log.warn(message, t);
		}
	}

	public static final String DIAGNOSTICS_DEST_PROPERTY = "org.apache.commons.logging.diagnostics.dest";

	public static final String FACTORY_DEFAULT = "org.apache.commons.logging.impl.LogFactoryImpl";

	public static final String FACTORY_PROPERTIES = "commons-logging.properties";

	public static final String FACTORY_PROPERTY = "org.apache.commons.logging.LogFactory";

	public static final String HASHTABLE_IMPLEMENTATION_PROPERTY = "org.apache.commons.logging.LogFactory.HashtableImpl";

	public static final String PRIORITY_KEY = "priority";

	public static final String TCCL_KEY = "use_tccl";

	public static LogFactory getFactory() throws LogConfigurationException {
		return new LogFactory();
	}

	public static Log getLog(final Class clazz)
			throws LogConfigurationException {
		return LogFactory.getLog(clazz.getName());
	};

	/**
	 * Convenience method to return a named logger, without the application
	 * having to care about factories.
	 * 
	 * @param name
	 *            Logical name of the <code>Log</code> instance to be returned
	 *            (the meaning of this name is only known to the underlying
	 *            logging implementation that is being wrapped)
	 * 
	 * @exception LogConfigurationException
	 *                if a suitable <code>Log</code> instance cannot be
	 *                returned
	 */
	public static Log getLog(final String name)
			throws LogConfigurationException {
		return new CLog(name);
	}

	public static String objectId(final Object o) {
		if (o == null) {
			return "null";
		} else {
			return o.getClass().getName() + "@" + System.identityHashCode(o);
		}
	}

	public static void release(final ClassLoader classLoader) {
	}

	public static void releaseAll() {
	}

	private final Map map = new HashMap();

	protected LogFactory() {
	}

	public Object getAttribute(final String name) {
		synchronized (this.map) {
			return this.map.get(name);
		}
	}

	public String[] getAttributeNames() {
		synchronized (this.map) {
			return (String[]) this.map.keySet().toArray(
					new String[this.map.size()]);
		}
	}

	public Log getInstance(final Class clazz) throws LogConfigurationException {
		return LogFactory.getLog(clazz);
	}

	public Log getInstance(final String name) throws LogConfigurationException {
		return LogFactory.getLog(name);
	}

	public void release() {
		synchronized (this.map) {
			this.map.clear();
		}
	}

	public void removeAttribute(final String name) {
		synchronized (this.map) {
			this.map.remove(name);
		}
	}

	public void setAttribute(final String name, final Object value) {
		synchronized (this.map) {
			this.map.put(name, value);
		}
	}
}
